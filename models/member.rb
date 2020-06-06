require_relative('../db/sqlrunner')

class Member
    attr_accessor :name, :dob, :pin
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @dob = options['dob']
        @pin = options['pin']
        if @id.nil?
            save
        end
    end

    def save()
        sql = "INSERT INTO members
                (name, dob, pin)
                VALUES ($1, $2, $3)
                RETURNING id;"
        values = [@name, @dob, @pin]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i()
    end
end
