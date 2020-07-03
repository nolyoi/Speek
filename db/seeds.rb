# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(name: "Nolan M.", username: "nolyoi", bio: "I am a 29 year old software engineer from shitty Northwest Indiana, USA.", password: "password", password_confirmation: "password")
community = admin.communities.create(name: "Bitcoin Community", description: "This is a community for BTC enthusiasts.")

40.times do
  user = User.create(name: Faker::Name.unique.name, username: Faker::Twitter.unique.screen_name, password: "password", password_confirmation: "password")
  user.follows_given.create(following_id: 1)
  user.posts.create(body: "Hello World!")
end