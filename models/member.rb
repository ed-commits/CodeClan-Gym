require_relative('../db/sqlrunner')

class Member
    attr_accessor :name, :dob, :pin
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @dob = options['dob']
        @pin = options['pin']
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
                (name, dob, pin)
                VALUES ($1, $2, $3)
                RETURNING id;"
        values = [@name, @dob, @pin]
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
                SET (name, dob, pin)
                = ($2, $3, $4)
                WHERE id = $1"
        values = [@id, @name, @dob, @pin]
        SqlRunner.run(sql, values)
    end
end
