# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Plant.destroy_all
Log.destroy_all
Comment.destroy_all

 20.times do
     User.create(name: Faker::Name.name, username: Faker::FunnyName.name, email:Faker::Internet.email, password: "happy", password_confirmation: "happy")
 end
   
 50.times do 
    Plant.create(nickname: Faker::FunnyName.two_word_name, plant_type: Faker::Lorem.word, user_id: User.all.sample.id)
 end
 
 30.times do
     Comment.create(content: Faker::Hipster.sentence, commenter_id: User.all.sample.id, plant_id: Plant.all.sample.id)
 end
  
 30.times do 
    Log.create(condition_update: Faker::Hipster.word, water_date: Faker::Date.between(from: 10.days.ago, to: Date.today), notes: Faker::Hipster.words(number: 8), plant_id: Plant.all.sample.id)
        end
  
