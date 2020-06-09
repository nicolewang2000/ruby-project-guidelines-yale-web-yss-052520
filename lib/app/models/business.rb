class Business < ActiveRecord::Base
    has_many :reservations
    has_many :users, through: :reservations

    def hours_helper
        # hours hash ex.
        # [{"open"=>
        #      [{"is_overnight"=>false, "start"=>"1700", "end"=>"2130", "day"=>0},
        #       {"is_overnight"=>false, "start"=>"1130", "end"=>"1430", "day"=>1},
        #       {"is_overnight"=>false, "start"=>"1700", "end"=>"2130", "day"=>1},
        #       {"is_overnight"=>false, "start"=>"1130", "end"=>"1430", "day"=>2},
        #       {"is_overnight"=>false, "start"=>"1700", "end"=>"2130", "day"=>2},
        #       {"is_overnight"=>false, "start"=>"1130", "end"=>"1430", "day"=>3},
        #       {"is_overnight"=>false, "start"=>"1700", "end"=>"2130", "day"=>3},
        #       {"is_overnight"=>false, "start"=>"1130", "end"=>"1430", "day"=>4},
        #       {"is_overnight"=>false, "start"=>"1700", "end"=>"2200", "day"=>4},
        #       {"is_overnight"=>false, "start"=>"1130", "end"=>"1430", "day"=>5},
        #       {"is_overnight"=>false, "start"=>"1700", "end"=>"2200", "day"=>5},
        #       {"is_overnight"=>false, "start"=>"1100", "end"=>"1430", "day"=>6},
        #       {"is_overnight"=>false, "start"=>"1700", "end"=>"2100", "day"=>6}],
        #     "hours_type"=>"REGULAR",
        #     "is_open_now"=>true}],
        
    end

    def detailed_info(yelp_business_id)
        ApiAdapter.business(yelp_business_id)
    end
end