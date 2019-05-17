# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NUMBER_OF_STEPS = 3

puts "step 1/#{NUMBER_OF_STEPS} Sign up initial users(not admin)"
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

puts "step 2/#{NUMBER_OF_STEPS} Sign up initial admin user "
User.create!(name: "admin",
              email: "admin@a.com",
              password: "adminuser",
              password_confirmation: "adminuser",
              admin: true
              )

puts "step 3/#{NUMBER_OF_STEPS} Sign up initiak labels"
Label.create!(name: "housework",
              color: "lemonchiffon"
              )

Label.create!(name: "paper_work",
              color: "pink"
              )

Label.create!(name: "date",
              color: "aquamarine"
              )