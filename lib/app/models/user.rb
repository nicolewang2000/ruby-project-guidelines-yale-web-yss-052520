require "tty-prompt"
prompt = TTY::Prompt.new

class User < ActiveRecord::Base
    has_many :reservations
    has_many :businesses, through: :reservations

    def self.create_username(un)
        self.find_or_create_by(username :un)
    end
    
    def self.create_username(un)
        self.create(username: un)
    end

    def self.exsisting_user?(un)
        self.find_by(username: un)
    end 

    def self.update_name_given_un(un, n)
        self.find_username(un).update(name: n)
    end

    def self.update_password_given_un(un, pwd)
        self.find_username(un).update(password: pwd)
    end

    def self.valid_login?(un, pwd)
        !self.find_by(username: un, password: pwd).nil?
    end

end