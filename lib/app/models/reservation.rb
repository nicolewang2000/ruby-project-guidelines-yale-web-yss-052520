require 'date'

class Reservation < ActiveRecord::Base
    belongs_to :business
    belongs_to :user

    def is_valid?
        within_hours? && !past?
    end

    def within_hours?
        hours = self.business.hours_helper[week_day_helper(self.date)]
        time = hour_minute_helper(self.date)
        hours.each do |times|
            return true if time.between?(times[0].to_i, times[1].to_i)
        end
        return false
    end

    def past?
        return true if !self.date
        Time.now > self.date
    end

    def readable_date
        date.strftime("%A, %B %d %Y, %l:%M %p")
    end
end

def week_day_helper(date)
    date.strftime("%A")
end

def hour_minute_helper(date)
    date.strftime("%k%M").to_i
end