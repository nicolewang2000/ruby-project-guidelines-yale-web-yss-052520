require_relative "../config/environment.rb"

User.destroy_all
Business.destroy_all


user1 = User.create(name: "Stacy Cohen", username: "staceycohen", password: "ilovedogs")
user2 = User.create(name: "Ben Ten", username: "benny101", password: "ilovecats")
user3 = User.create(name: "Jonathan Paul", username: "jpmorgan", password: "301")
user4 = User.create(name: "Annabeth Chase", username: "Camp.HB", password: "percyjackson")
user5 = User.create(name: "Nicole Wang", username: "nickel", password: "iam19")

# business1 = Business.create(name: "Wendy's", address: "20008")
# business2 = Business.create(name: "Arby's", address: "20008")
# business3 = Business.create(name: "Blue 44", address: "20015")
# business4 = Business.create(name: "Medium Rare", address: "20014")
# business5 = Business.create(name: "Chipotle", address: "20016")

reservation1 = Reservation.create(date: Time.now, user_id: 1, business_id: business3.id)
reservation2 = Reservation.create(date: Time.now, user_id: user4.id, business_id: business4.id)
