# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do |n|
  name = Faker::Games::Zelda.character
  email = Faker::Internet.email
  password = "123456"
  admin = false
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: admin
               )
end

User.create!(name: "admin",
              email: "admin@a.com",
              password: "adminuser",
              password_confirmation: "adminuser",
              admin: true
              )