require_relative('../db/sqlrunner')

require_relative('./gymclass')
require_relative('./member')

class Booking
    attr_accessor :member_id, :class_id
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @member_id = options['member_id']
        @class_id = options['class_id']
        if @id.nil?
            save
        end
    end

    def save()
        sql = "INSERT INTO bookings
                (member_id, class_id)
                VALUES ($1, $2)
                RETURNING id;"
        values = [@member_id, @class_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end

    def delete()
        sql = "DELETE FROM bookings
                WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all
        sql = "DELETE FROM bookings;"
        SqlRunner.run(sql)
    end

    def self.create_for_class_and_pin(id, pin)
        clss = GymClass.by_id(id)
        member = Member.by_pin(pin)
        
        if clss.nil? || member.nil?
            return nil
        end

        return Booking.new({
            "class_id" => clss.id,
            "member_id" => member.id
        })
    end
end
