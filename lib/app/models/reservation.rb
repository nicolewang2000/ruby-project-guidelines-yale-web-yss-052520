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
        within_hours? && !past?
    end

    def within_hours?
        hours = self.business.hours_helper[week_day_helper(self.date)]
        time = hour_minute_helper(self.date)
        hours.each_slice(2) do |times|
            return true if time.between?(times[0].to_i, times[1].to_i)
        end
        return false
    end

    def past?
        return true if !self.date
        Time.now > self.date
    end

    def readable_date
        date_in_time_zone.strftime("%A, %B %d %Y, %l:%M %p")
    end

    def date_in_time_zone
        date.in_time_zone(time_zone)
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