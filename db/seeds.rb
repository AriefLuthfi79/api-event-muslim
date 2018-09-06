# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "arief@gmail.com",
						password: "oke@Guys",
						password_confirmation: "oke@Guys",
						confirmation_token: nil,
						confirmation_sent_at: Time.now,
						confirmated_at: Time.now)

3.times do |n|
	event_name = Faker::Lorem.sentence(5)
	event_description = Faker::Lorem.sentence(20)
	date = "#{Time.now}"
	time = "#{Time.now}"
	place = "Jogja"
	Event.create!(user_id: 1,
								name: event_name,
								description: event_description,
								date: date,
								time: time,
								time_event: Time.now,
								place: place)
end

current_user = User.find(1)

# 5.times do |n|
# 	current_user.attend(Event.find(n))
# end
