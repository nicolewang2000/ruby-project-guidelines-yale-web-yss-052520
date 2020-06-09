require 'date'

class Reservation < ActiveRecord::Base
    belongs_to :business
    belongs_to :user

# Choose restaurant from list to make reservation
# Given restaurant name, display hours
# User chooses date/time + # of people
# Create new instance of Business object
# Given those arguments, create new instance of Reservation class for that user_id/business_id
end

# to get hours, must make GET request using business ID

# helper method 

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


def datetime_helper(time)
end