class Business < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations
    
    def detailed_info
        # should add custom error for if yelp_business_id is unknown/not included?
        ApiAdapter.business(yelp_business_id)
    end
    
    def self.create_business_from_search(term, location)
        ApiAdapter.search(term, location)["businesses"].each do |business|
            Business.find_or_create_by(yelp_business_id: business["id"], name: business["name"], avg_rating: business["rating"], review_count: business["review_count"], price: business["price"], address: business["location"]["display_address"].join(" "))
        end
    end
      
    # This allows you to return a table of the searched results
    def self.list_of_business(term, location)
        Business.where(yelp_business_id: ApiAdapter.ids(term, location))
    end
    
    def self.asc_price(term, location)
        self.list_of_business(term, location).order(price: :asc)
    end

    def self.desc_price(term, location)
        self.list_of_business(term, location).order(price: :desc)
    end

    def self.asc_rating(term, location)
        self.list_of_business(term, location).order(avg_rating: :asc)
    end

    def self.desc_rating(term, location)
        self.list_of_business(term, location).order(avg_rating: :desc)
    end

    def self.asc_review_count(term, location)
        self.list_of_business(term, location).order(review_count: :asc)
    end

    def self.desc_review_count(term, location)
        self.list_of_business(term, location).order(review_count: :desc)
    end




    # daynames constant adjusted so Day 0 = Monday
    DAYNAMES = Date::DAYNAMES.rotate(1)

    # returns hash w/ daynames as keys pointing to arrays of start and end times
    # if business has multiple start/end times in one day, array = [start, end, start, end, etc.]
    def hours_helper
        detailed_info["hours"][0]["open"].each_with_object({}) do |day_info, hours_read|
            if hours_read[DAYNAMES[day_info["day"]]]
                hours_read[DAYNAMES[day_info["day"]]].push([day_info["start"], day_info["end"]])
            else
                hours_read[DAYNAMES[day_info["day"]]] = [[day_info["start"], day_info["end"]]]
            end
        end
    end
    
end


