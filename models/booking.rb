require_relative('../db/sqlrunner')

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
end
