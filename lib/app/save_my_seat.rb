require 'pastel'
require 'tty-prompt'
require 'tty-font'
require 'pry'
require 'table_print'

class SaveMySeat
    attr_accessor :user, :reservation, :business
   
    # @@pastel = Pastel.new
    # @@font = TTY::Font.new(:standard)
    # @@prompt = TTY::Prompt.new

    def run
        # Outline

        # Welcome! 
        # - ask if you have an account
        #   - if yes
        #       - get username
        #       - check if username exists
        #       - either prompt for password or prompt to create account (User does not exist)
        #   - if no
        #       - prompt to create account
        #       - prompt to login 
        
        # Logged In!
        # - Would you like to view your reservations?
        # - Would you like to execute a search?

        # Business Search
        # - To search businesses: Ask for current location + cuisine type
        #   - execute search (create business instances for results)
        #   - prompt user to choose sorting method
        #   - print out search list (self.list_of_businesses)
        #   - prompt user to execute new search/different sorting method/make reservation

        # def business_search
        #   helper methods that do the things we outline
        # end

        # Manage Reservations
        # - list reservations or say "you have no reservations at this time"
        # - Give user option to delete reservations

        # Choosing Business for Reservation
        # - Prompt user to choose a business
        # - Retrieve and display business hours
        # - Prompt user to choose reservation date/guest_number
        #   - check if reservation is valid
        # - Once validity is good, ask user to confirm
        # - Once confirmed, persist reservation to database


        # Pseudocode

        # welcome
        # login page


    end
    
    def greeting
        puts Pastel.new.magenta(TTY::Font.new(:standard).write "Welcome to:")
        puts Pastel.new.cyan(TTY::Font.new(:standard).write "Save My Seat")
        sleep(1)
        new_or_returning?
    end

    def new_or_returning?
        TTY::Prompt.new.yes?("Do you have an existing account?") ? (login_returning_user) : (get_new_username)
    end

    def login_returning_user
        # puts "Please enter your username:"
        # un = gets.chomp
        # puts "Please enter your password: "
        # pwd = gets.chomp
        
        un = TTY::Prompt.new.ask("Username:", required: true)
        pwd = TTY::Prompt.new.mask("Password:", required: true)
        
        if User.valid_login?(un, pwd)
            puts Pastel.new.green("Login successful")
            sleep(1)
            search 
        elsif User.existing_user?(un).nil? 
            puts Pastel.new.red("This username does not exist")
            sleep(0.5)
            new_or_returning?
        else 
            puts Pastel.new.red("This password is incorrect")
            sleep(0.5)
            new_or_returning?
        end

    end 

    def get_new_username
        # puts "Please enter a new username:"
        # un = gets.chomp
        un = TTY::Prompt.new.ask("Please enter a new username:", required: true)
        if User.existing_user?(un)
            puts Pastel.new.red("Sorry. This username is already taken.")
            get_new_username
        else
            User.create_username(un)
            get_name(un)
        end
    end

    def get_name(un)
        # puts "Please enter your first and last name:"
        response = TTY::Prompt.new.ask("Please enter your first and last name:", required: true)
        n = response.split.each {|name| name.capitalize!}.join(' ')
        if n.split.length != 2
            puts Pastel.new.red("Invalid response. Make sure your enter your first and last name.")
            get_name(un)
        end
        User.update_name_given_un(un, n)
        get_pwd(un)
    end
    
    def get_pwd(un)
        # puts "Please enter a password:"
        # pwd = gets.chomp
        pwd = TTY::Prompt.new.ask("Please enter a password:", required: true)
        if pwd.split.length != 1 || pwd.length == 0 
            puts Pastel.new.red("Invalid password.")
            get_pwd(un)
        end
        User.update_password_given_un(un, pwd)
        puts Pastel.new.green("Success! You have made an account. Please proceed to login.")
        sleep(1)
        login_returning_user
    end 

    def search
        # puts "What are you craving for? (e.g. 'Salad', 'Taco', 'Breakfast', 'Brunch', 'Chinese', 'Italian')"
        # term = gets.chomp
        # puts "Where do you want to eat today? Please provide your current zipcode or city. (e.g. 'NYC', '06510', 'Brooklyn')"
        # location = gets.chomp
        term = TTY::Prompt.new.ask("What are you craving for? (e.g. 'Salad', 'Taco', 'Breakfast', 'Brunch', 'Chinese', 'Italian')", required: true)
        location = TTY::Prompt.new.ask("Where do you want to eat today? Please provide your current zipcode or city. (e.g. 'NYC', '06510', 'Brooklyn')", required: true)

        # choices = %w(best_match ascending_price decreasing_price ascending_rating decreasing_rating ascending_reviews decreasing_reviews)
        # result = TTY::Prompt.new.select("How would you like to filter your results by?", choices)

        result = TTY::Prompt.new.select("How would you like to filter your results by?") do |menu|
            menu.choice "best match"
            menu.choice "ascending price"
            menu.choice "decreasing price"
            menu.choice "ascending rating"
            menu.choice "decreasing rating"
            menu.choice "ascending reviews"
            menu.choice "decreasing reviews"
        end

        Business.create_business_from_search(term, location)
        if result ==  "best match"
            tp Business.list_of_business(term, location)
        elsif result == "ascending price"
            tp Business.asc_price(term, location)
        elsif result == "decreasing price"
            tp Business.desc_price(term, location)
        elsif result == "ascending rating" 
            tp Business.asc_rating(term, location)
        elsif result == "decreasing rating"
            tp Business.desc_rating(term, location)
        elsif result == "ascending reviews"
            tp Business.asc_review_count(term, location)
        elsif result == "decreasing reviews"
            tp Business.desc_review_count(term, location)
        end
    end
end
