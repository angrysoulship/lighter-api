# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

User.destroy_all


user = User.new(nickname: 'Alice')
user.save
user1 = User.new(nickname: 'Bob')
user1.save
user2 = User.new(nickname: 'Charlie')
user2.save
user3 = User.new(nickname: 'Danny')
user3.save
user4 = User.new(nickname: 'Eric')
user4.save



User.all.each do |user| 
  new_post = Post.create(
    user: user,
    mood: Faker::Emotion.noun, 
    text: Faker::Quote.famous_last_words,
    date: Faker::Date.in_date_period
  )
  new_post.save
  new_post1 = Post.create(
    user: user,
    mood: Faker::Emotion.noun, 
    text: Faker::Quote.famous_last_words,
    date: Faker::Date.in_date_period
  )
  new_post1.save
end

puts "save"