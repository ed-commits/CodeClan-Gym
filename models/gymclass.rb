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

    def self.map_new(collection)
        collection.map{|parameters| GymClass.new(parameters)}
    end

    def self.classes
        # List all classes
        sql = "SELECT * FROM classes;"
        GymClass.map_new(SqlRunner.run(sql))
    end

    def self.classes_this_month
        # List all classes this month

        # Get the first day of this month
        first_day = Date.new(Date.today.year, Date.today.month, 1)
        # next month
        ## TODO: what happens in december?
        last_day = Date.new(Date.today.year, Date.today.month + 1, 1)

        sql = "SELECT * FROM classes
                WHERE day >= $1 AND day < $2;"
        values = [first_day.strftime("%Y-%m-%d"), last_day.strftime("%Y-%m-%d")]
        GymClass.map_new(SqlRunner.run(sql, values))
    end
end
