require_relative('./sqlrunner')

require_relative('../models/member')

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
