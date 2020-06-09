require_relative('../db/sqlrunner')

class Member
    attr_accessor :name, :dob, :pin, :active
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @dob = options['dob']
        @pin = options['pin']
        @active = 1
        @active = options['active'].to_i if options['active']
        if valid? && @id.nil?
            if @pin.nil?
                generate_pin
            end
            save
        end
    end

    def age
        days_lived = (Date.today - Date.parse(@dob)).to_i
        return days_lived / 365
    end

    def valid?
        begin
            return age > 16
        rescue
            # We couldn't convert the @dob string to a date
            # So it wasn't a valid date of birth
            return false
        end
    end

    def generate_pin
        a = Random.rand(0...10)
        b = Random.rand(0...10)
        c = Random.rand(0...10)
        d = Random.rand(0...10)

        ## TODO: check this isn't an existing PIN

        @pin = "#{a}#{b}#{c}#{d}"
    end

    def save()
        sql = "INSERT INTO members
                (name, dob, pin, active)
                VALUES ($1, $2, $3, $4)
                RETURNING id;"
        values = [@name, @dob, @pin, @active]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def delete()
        sql = "DELETE FROM members
                WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all
        sql = "DELETE FROM members;"
        SqlRunner.run(sql)
    end

    def update()
        sql = "UPDATE members
                SET (name, dob, pin, active)
                = ($2, $3, $4, $5)
                WHERE id = $1"
        values = [@id, @name, @dob, @pin, @active]
        SqlRunner.run(sql, values)
    end

    def terminate()
        @active = 0
        update
    end

    def self.by_pin(pin)
        sql = "SELECT * FROM members
                WHERE pin = $1;"
        values = [pin]
        result = SqlRunner.run(sql, values)
        
        if result.ntuples == 1
            Member.new(result[0])
        else
            return nil
        end
    end

    def self.by_name_and_dob(name, dob)
        sql = "SELECT * FROM members
                WHERE (name, dob) = ($1, $2);"
        values = [name, dob]
        result = SqlRunner.run(sql, values)
        
        if result.ntuples == 1
            Member.new(result[0])
        else
            return nil
        end
    end

    def self.sign_up(name, dob)
        member = Member.by_name_and_dob(name, dob)
        if member
            member.active = 1
            member.update
            return member, :reactivated
        else
            member = Member.new({
                "name" => name,
                "dob" => dob
            })
            if member.valid?
                return member, :success
            else
                return nil, :fail
            end
        end
    end
end
