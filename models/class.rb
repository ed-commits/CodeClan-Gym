require_relative('../db/sqlrunner')

class Class
    attr_accessor :name, :instructor, :time_slot, :day, :capacity
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @intructor = options['instructor']
        @time_slot = options['time_slot']
        @day = options['day']
        @capacity = options['capacity']
        if @id.nil?
            save
        end
    end

    def save()
        sql = "INSERT INTO classes
                (name, instructor, time_slot, day, capacity)
                VALUES ($1, $2, $3, $4, $5)
                RETURNING id;"
        values = [@name, @instructor, @time_slot, @day, @capacity]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end
end
