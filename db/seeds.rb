require_relative "../config/environment.rb"

User.destroy_all
User.reset_pk_sequence
Business.destroy_all
Business.reset_pk_sequence
Reservation.destroy_all
Reservation.reset_pk_sequence

user1 = User.create(name: "Stacy Cohen", username: "staceycohen", password: "ilovedogs")
user2 = User.create(name: "Ben Ten", username: "benny101", password: "ilovecats")
user3 = User.create(name: "Jonathan Paul", username: "jpmorgan", password: "301")
user4 = User.create(name: "Annabeth Chase", username: "Camp.HB", password: "percyjackson")
user5 = User.create(name: "Nicole Wang", username: "nickel", password: "iam19")


business1 = Business.create(name: "Wendy's")
business2 = Business.create(name: "Arby's")
business3 = Business.create(name: "Blue 44", yelp_business_id: "aSSAdDLspXrZK81mlxrFFg")
business4 = Business.create(name: "Medium Rare")
business5 = Business.create(name: "Chipotle")

reservation1 = Reservation.create(date: Time.now, user_id: 1, business_id: business3.id, time_zone: "EST")
reservation2 = Reservation.create(date: Time.now, user_id: user4.id, business_id: business4.id, time_zone: "EST")
reservation3 = Reservation.create(date: Time.now, user_id: 1, business_id: business3.id, time_zone: "EST")

# binding.pry
# 0
