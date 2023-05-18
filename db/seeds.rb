# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

names = [
  "Alice",
  "Bob",
  "Carol",
  "Dave",
  "Eve",
  "Frank",
  "Grace",
  "Heidi",
  "Ivan",
  "Jenny",
  "Kevin",
  "Lazy",
  "Mallory",
  "Nancy",
  "Oscar",
  "Peggy",
  "Quentin",
  "Roger",
  "Sam",
  "Trent",
  "Uma",
  "Victor",
  "Walter",
  "Xavier",
  "Yvonne",
  "Zoe",
]

names.each do |name|
  user = Api::V1::User.create({
    name: name,
    email: "#{name}@test.seed",
    password: "#{name}password"
  })

  

  entries = rand(2..101)

  entries = unless name == "Lazy"
    rand(10)
  else
    0
  end

  entries.times do |i|
    record = Api::V1::Record.new({
      travelled_distance: rand(1.0..500.0),
      user: user
    })

    record.created_at = rand((DateTime.now - 2.years)..DateTime.now) # set a specific created_at timestamp

    record.save
  end

  if name == "Lazy"
    record = Api::V1::Record.new({
      travelled_distance: 1.0,
      user: user
    })

    record.created_at = rand((DateTime.now - 2.years)..DateTime.now) # set a specific created_at timestamp

    record.save
  end
end
