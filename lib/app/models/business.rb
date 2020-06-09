class Business < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations

    # daynames constant adjusted so Day 0 = Monday
    DAYNAMES = Date::DAYNAMES.rotate(1)

    # returns hash w/ daynames as keys pointing to arrays of start and end times
    # if business has multiple start/end times in one day, array = [start, end, start, end, etc.]
    def hours_helper
        detailed_info["hours"][0]["open"].each_with_object({}) do |day_info, hours_read|
            if hours_read[DAYNAMES[day_info["day"]]]
                hours_read[DAYNAMES[day_info["day"]]].push(day_info["start"])
                hours_read[DAYNAMES[day_info["day"]]].push(day_info["end"])
            else
                hours_read[DAYNAMES[day_info["day"]]] = [day_info["start"], day_info["end"]]
            end
        end
    end

    def detailed_info
        ApiAdapter.business(yelp_business_id)
    end
end