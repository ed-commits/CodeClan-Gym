require_relative('../db/sqlrunner')

class GymClass
    attr_accessor :name, :instructor, :time_slot, :day, :capacity
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @instructor = options['instructor']
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

    def delete()
        sql = "DELETE FROM classes
                WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all
        sql = "DELETE FROM classes;"
        SqlRunner.run(sql)
    end

    def update()
        sql = "UPDATE classes
                SET (name, instructor, time_slot, day, capacity)
                = ($2, $3, $4, $5, $6)
                WHERE id = $1"
        values = [@id, @name, @instructor, @time_slot, @day, @capacity]
        SqlRunner.run(sql, values)
    end
end
