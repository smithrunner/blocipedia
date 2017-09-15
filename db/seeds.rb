require 'faker'

# Create Users
10.times do
    User.create!(
        name:     Faker::Name.name,
        email:    Faker::Internet.email,
        password: Faker::Address.city
    )
end
users = User.all

50.times do
    wiki = Wiki.create!(
        user:  users.sample,
        title: Faker::Seinfeld.character,
        body:  Faker::Seinfeld.quote
    )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"