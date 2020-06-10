require_relative "../config/environment.rb"

#clear database before re-seeding
User.destroy_all
User.reset_pk_sequence
Business.destroy_all
Business.reset_pk_sequence
Reservation.destroy_all
Reservation.reset_pk_sequence


user1 = User.create(name: "Stacy", password: "ilovedogs", zipcode: "20015")
user2 = User.create(name: "Ben", password: "ilovecats", zipcode: "20016")
user3 = User.create(name: "Jonathan", password: "301", zipcode: "06510")
user4 = User.create(name: "Annabeth", password: "percyjackson", zipcode: "06510")

business1 = Business.create(name: "Wendy's")
business2 = Business.create(name: "Arby's")
business3 = Business.create(name: "Blue 44", yelp_business_id: "aSSAdDLspXrZK81mlxrFFg")
business4 = Business.create(name: "Medium Rare")
business5 = Business.create(name: "Chipotle")

reservation1 = Reservation.create(date: Time.now, user_id: 1, business_id: business3.id)
reservation2 = Reservation.create(date: Time.now, user_id: user4.id, business_id: business4.id)

# binding.pry
# 0
