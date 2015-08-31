 require 'faker'
 
 # Create Users
 5.times do
   user = User.new(
     name:     Faker::Name.name,
     email:    Faker::Internet.email,
     password: Faker::Lorem.characters(8)
   )
 user.skip_confirmation!
 user.save!
 end
 users = User.all

 user = User.first
 user.skip_reconfirmation!
 user.update_attributes!(
   email: 'abmjosh@gmail.com',
   password: 'jlbsk811'
 )

user = User.second
 user.skip_reconfirmation!
 user.update_attributes!(
   email: 'someemail@email.com',
   password: 'helloworld',
   role: 'standard'
 )


 # Create an admin
 admin = User.new(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!
 
 # Create a premium user
 moderator = User.new(
   name:     'Premium User',
   email:    'premium@example.com',
   password: 'helloworld',
   role:     'premium'
 )
 moderator.skip_confirmation!
 moderator.save!
 
 # Create a member
 member = User.new(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )
 member.skip_confirmation!
 member.save!


# Create Wikis
 10.times do
   Wiki.create!(
     user:   users.sample,
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph,
   )
 end
wikis = Wiki.all


puts "Seed finished"
