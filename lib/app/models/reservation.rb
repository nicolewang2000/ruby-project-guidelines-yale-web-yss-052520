require 'date'

class Reservation < ActiveRecord::Base
    belongs_to :business
    belongs_to :user

# Choose restaurant from list to make reservation
# Given restaurant name, display hours
# User chooses date/time + # of people
# Create new instance of Business object
# Given those arguments, create new instance of Reservation class for that user_id/business_id

    # Given reservation instance, determine whether it is still valid
    def is_valid?

    end

    def within_hours?
        hours = self.business.hours_helper[week_day_helper(self.date)]
        time = hour_minute_helper(self.date)
        # Next steps:
        #   - check to split hours array into twos (start/end pairs)
        #   - check if time is between start/end times
        hours.each_slice(2) do |times|
            return true if time.between?(times[0].to_i, times[1].to_i)
        end
        return false
    end

    def past?

    end
end

# to get hours, must make GET request using business ID

# helper methods 

# def hours_split_helper(hours)

# end

def week_day_helper(date)
    date.strftime("%A")
end

def hour_minute_helper(date)
    date.strftime("%k%M").to_i
end