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
        current_user = greeting
        make_reservation?(current_user)

        while true
            result = home_page
            case result
            when "Make new search"
                search
                make_reservation?(current_user)
            when "View current reservations"
                manage_reservations(current_user)
            when "Log out"
                log_out
                break
            end
        end
        
            

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

    def make_reservation?(current_user)
        if make_reservation_prompt
            choose_restaurant_and_make_reservation(current_user)
        end
    end

    def log_out
        puts "Thanks for craving! See you soon"
    end

    def home_page
        result = TTY::Prompt.new.select("What would you like to do?") do |menu|
            menu.choice "Make new search"
            menu.choice "View current reservations"
            menu.choice "Log out"
        end
    end

    # def search_or_manage_reservations?
    #     result = TTY::Prompt.new.select("What would you like to do?") do |menu|
    #         menu.choice "Make new search"
    #         menu.choice "View current reservations"
    #     end
    # end

    def make_reservation_prompt
        prompt = TTY::Prompt.new
        prompt.yes?("Would you like to make reservation at one of these restaurants?")
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
        return User.find_by username: un
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

    private

    def manage_reservations(user)
        print_reservations(user)
        if delete_any_reservations_prompt?
            delete_reservation_master(user)
        end
    end

    def choose_restaurant_and_make_reservation(user)
        restaurant = find_restaurant_by_name(choose_restaurant_prompt)
        if !restaurant
            puts "Restaurant not found. Please re-enter name exactly as it appears above."
            choose_restaurant_and_make_reservation
        end
        display_restaurant_hours(restaurant)
        make_reservation(user, restaurant)
    end

    # making reservation helper methods

    def make_reservation(user, business)
        details = choose_date_and_guests_prompt
        reservation = user.new_reservation(details[:guest_number], Time.parse(details[:date]), business.id)
        # binding.pry
        if reservation.is_valid?
            user.confirm_reservation(reservation) if confirm_reservation_prompt(reservation)
        else 
            prompt = TTY::Prompt.new
            puts "Sorry, reservation date invalid."
            if prompt.yes?("Would you like to choose a different date?")
                make_reservation(user, business)
            end
        end
    end

    def confirm_reservation_prompt(reservation)
        puts "#{reservation.business.name}, #{reservation.date.strftime("%A, %B %d, %l:%M %p")}"
        prompt = TTY::Prompt.new
        prompt.yes?("Is this correct?")
    end

    def choose_date_and_guests_prompt
        prompt = TTY::Prompt.new
        prompt.collect do 
            key(:date).ask("Date? Please format as 'June 11 7:00pm'")
            key(:guest_number).ask("How many guests? Enter numerical value (i.e. 2, not two)")
        end
    end

    def display_restaurant_hours(business)
        business.hours_helper.each do |key, values|
            puts "#{key}'s hours:"
            values.each do |time_pair|
                puts "#{hour_minute_helper2(time_pair[0])} - #{hour_minute_helper2(time_pair[1])}"
            end
        end
    end

    def hour_minute_helper2(time)
        time_arr = time.chars
        Time.parse("#{time_arr[0]}#{time_arr[1]}:#{time_arr[2]}#{time_arr[3]}").strftime("%l:%M %p").strip
    end

    def choose_restaurant_prompt
        prompt = TTY::Prompt.new
        prompt.ask("Enter the full name of the restaurant you would like to make a reservation at")
    end

    def find_restaurant_by_name(name)
        Business.find_by name: name.chomp
    end


    # manage reservation helper methods

    def print_reservations(user)
        return "You have no reservations at this time." if user.reservations.count == 0
        user.reservation_list_helper.each{|reservation| p "Restaurant: #{reservation[0]}, Date: #{reservation[1]}, Guests: #{reservation[2]}"}
    end

    def delete_reservation_master(user)
        if delete_past_reservations_prompt?
            user.clear_past_reservations
        elsif delete_single_reservation_prompt?
            print_reservations(user)
            choice = choose_reservation_prompt
            execute_reservation_delete(choice, user)
        end
    end

    def delete_any_reservations_prompt?
        prompt = TTY::Prompt.new
        prompt.yes?("Would you like to delete any reservations?")
    end

    def delete_past_reservations_prompt?
        prompt = TTY::Prompt.new
        prompt.yes?("Would you like to delete all past reservations?")
    end

    def delete_single_reservation_prompt?
        prompt = TTY::Prompt.new
        prompt.yes?("Would you like to delete a single reservation?")
    end

    def choose_reservation_prompt
        prompt = TTY::Prompt.new
        prompt.collect do 
            key(:name).ask("Restaurant name?")
            key(:date).ask("Date and time of reservation?")
        end
    end

    def execute_reservation_delete(choice, user)
        new_business_id = find_restaurant_by_name(choice[:name]).id
        new_date = Time.parse(choice[:date])

        chosen_reservation = Reservation.find_by user_id: user.id, business_id: new_business_id, date: new_date
        if chosen_reservation
            user.delete_reservation(chosen_reservation)
        else puts "Reservation not found."
        end
    end

end
