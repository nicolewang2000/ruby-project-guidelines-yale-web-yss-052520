class User < ActiveRecord::Base
    has_many :reservations
    has_many :businesses, through: :reservations

    # create instance but wait for user confirmation to save
    def new_reservation(guest_number, date, business_id)
        Reservation.new(guest_number: guest_number, user_id: self.id, business_id: business_id, date: date)
    end

    def confirm_reservation(reservation)
        self.reservations.push(reservation)
        reservation.save
    end

    # accepts API business hash to create new business instance
    def new_business_from_API(business)
        self.businesses.push(Business.create(yelp_business_id: business["id"], name: business["name"], address: business["display_address"], avg_rating: business["rating"], review_count: business["review_count"]))
    end

    def clear_past_reservations
        self.reservations.each do |reservation| 
            if reservation.past?
                delete_reservation(reservation)
            end
        end
    end

    def delete_reservation(reservation)
        self.reservations.delete(reservation)
        reservation.delete
    end
end