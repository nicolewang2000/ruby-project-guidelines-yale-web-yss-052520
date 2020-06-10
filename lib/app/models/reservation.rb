require 'date'

class Reservation < ActiveRecord::Base
    belongs_to :business
    belongs_to :user

# Choose restaurant from list to make reservation
# Given restaurant name, display hours
# User chooses date/time + # of people
# Create new instance of Business object
# Given those arguments, create new instance of Reservation class for that user_id/business_id

    def is_valid?

    end
end

# to get hours, must make GET request using business ID

# helper method 



def datetime_helper(time)
end