# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


40.times do
  user = User.create(name: Faker::Name.unique.name, email: Faker::Internet.email, username: Faker::Twitter.unique.screen_name, password: "password", password_confirmation: "password")
  user.follows_given.create(following_id: 1)
  user.posts.create(body: "Hello World!")
end