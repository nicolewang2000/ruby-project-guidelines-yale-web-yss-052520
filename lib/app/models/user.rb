class User < ActiveRecord::Base
    has_many :reservations
    has_many :businesses, through: :reservations

    def new_reservation(guest_number, date, business_id)
        Reservation.new(guest_number: guest_number, user_id: self.id, business_id: business_id, date: date)
    end
end