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
  "lazy",
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

  entries = rand(1..11)

  entries = unless name == "lazy"
    rand(10)
  else
    0
  end

  entries.times do |i|
    Api::V1::Record.create({
      travelled_distance: rand(1.0..500.0),
      user: user
    })
  end
end
