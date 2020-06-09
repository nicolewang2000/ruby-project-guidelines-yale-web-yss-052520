class User < ActiveRecord::Base
    has_many :reservations
    has_many :businesses, through: :reservations
end