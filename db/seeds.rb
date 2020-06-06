require_relative('./sqlrunner')

require_relative('../models/member')
require_relative('../models/class')

Member.new({
    "name" => "Ed",
    "dob" => "02/Oct/1988",
    "pin" => 1234,
})

Member.new({
    "name" => "trainer Brock",
    "dob" => "12/Nov/1948",
    "pin" => 1010,
})

Member.new({
    "name" => "Cat",
    "dob" => "30/Jul/1982",
    "pin" => 1142,
})

Class.new({
    "name" => "Yoga",
    "instructor" => "Yogi Charles",
    "time_slot" => 0,
    "day" => "8/Jun/2020",
    "capacity" => 32,
})

Class.new({
    "name" => "Kettle Bell Blast",
    "instructor" => "Cathy",
    "time_slot" => 1,
    "day" => "9/Jun/2020",
    "capacity" => 4,
})

Class.new({
    "name" => "Pilates",
    "instructor" => "Zavi",
    "time_slot" => 0,
    "day" => "10/Jun/2020",
    "capacity" => 15,
})

#Class.new({
#    "name" => "",
#    "instructor" => ,
#    "time_slot" => ,
#    "day" => ,
#    "capacity" => ,
#})
