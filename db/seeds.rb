require('pry')

require_relative('./sqlrunner')

require_relative('../models/member')
require_relative('../models/gymclass')
require_relative('../models/booking')

Member.delete_all
GymClass.delete_all
Booking.delete_all

ed = Member.new({
    "name" => "Ed",
    "dob" => "02/Oct/1988",
    "pin" => 1234,
})

trainer = Member.new({
    "name" => "trainer Brock",
    "dob" => "12/Nov/1948",
    "pin" => 1010,
})

staff = Member.new({
    "name" => "Cat",
    "dob" => "30/Jul/1982",
    "pin" => 1142,
})

yoga = GymClass.new({
    "name" => "Yoga",
    "instructor" => "Yogi Charles",
    "time_slot" => 0,
    "day" => "8/Jun/2020",
    "capacity" => 32,
})

kbbl = GymClass.new({
    "name" => "Kettle Bell Blast",
    "instructor" => "Cathy",
    "time_slot" => 1,
    "day" => "9/Jun/2020",
    "capacity" => 4,
})

pilate = GymClass.new({
    "name" => "Pilates",
    "instructor" => "Zavi",
    "time_slot" => 0,
    "day" => "10/Jun/2020",
    "capacity" => 15,
})

# Add a class next month to test
# that classes this month works
plift = GymClass.new({
    "name" => "Power Lifting",
    "instructor" => "Bruce",
    "time_slot" => 0,
    "day" => "3/Jul/2020",
    "capacity" => 15,
})

#Class.new({
#    "name" => "",
#    "instructor" => ,
#    "time_slot" => ,
#    "day" => ,
#    "capacity" => ,
#})

Booking.new({
    "member_id" => ed.id,
    "class_id" => yoga.id
})

binding.pry
nil
