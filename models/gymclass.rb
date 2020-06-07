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

    def self.first_day_of_month
        return Date.new(Date.today.year, Date.today.month, 1)
    end

    def self.last_day_of_month
        ## TODO: what happens in december?
        return Date.new(Date.today.year, Date.today.month + 1, 1) - 1
    end

    def self.classes_this_month
        # List all classes this month
        sql = "SELECT * FROM classes
                WHERE day >= $1 AND day <= $2
                ORDER BY day;"
        values = [first_day_of_month.strftime("%Y-%m-%d"), last_day_of_month.strftime("%Y-%m-%d")]
        GymClass.map_new(SqlRunner.run(sql, values))
    end

    def self.classes_this_month_friendly
        # The classes this month is a sparse array of classes
        # make it into data that is more friendly for erb
        # to display by filling it and grouping it into weeks

        # Which weekday do we start on?
        starting_weekday = GymClass.first_day_of_month.wday
        
        # How many days does this month have?
        days_this_month = GymClass.last_day_of_month.day
        
        # How many weeks this month?
        rows = days_this_month/7

        # true represents a day of the month with nothing on
        # false represents a day outside the current month
        # When something is on a GymClass object will be put in that space
        weeks = Array.new(rows)
        weeks.each_index do |i|
            weeks[i] = Array.new(7, true)
        end

        # block out the days before this month starts
        (1...starting_weekday).each do |day|
            weeks[0][day-1] = false
        end

        # block out the days after this month ends
        (days_this_month % 7..7).each do |day|
            weeks[rows-1][day-1] = false
        end

        puts "YYYYYYYYYY"
        puts GymClass.classes_this_month
        GymClass.classes_this_month.each do |clss|
            class_mday = Date.parse(clss.day).mday + starting_weekday

            row = class_mday / 7
            col = class_mday % 7

            weeks[row][col-1] = clss
            puts "#{row} #{col}"
            puts "XXXXXXXXXXXXXXX"
        end

        return weeks
    end
end
