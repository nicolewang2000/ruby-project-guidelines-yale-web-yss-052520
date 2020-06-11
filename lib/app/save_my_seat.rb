class SaveMySeat

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

    

    def choose_restaurant_and_make_reservation(user)
        restaurant = find_restaurant_by_name(choose_restaurant_prompt)
        if !restaurant
            puts "Restaurant not found. Please re-enter name exactly as it appears above."
            choose_restaurant_and_make_reservation
        end
        display_restaurant_hours(restaurant)
        make_reservation(user, restaurant)
    end

    def make_reservation(user, business)
        details = choose_date_and_guests_prompt
        reservation = user.new_reservation(details[:guest_number], Time.parse(details[:date]), business.id)
        binding.pry
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
    
    private

    

    def manage_reservations(user)
        print_reservations(user)
        if delete_any_reservations_prompt?
            delete_reservation_master(user)
        end
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
        new_business_id = find_restaurant_id_by_name(choice[:name])
        new_date = Time.parse(choice[:date])

        chosen_reservation = Reservation.find_by user_id: user.id, business_id: new_business_id, date: new_date
        if chosen_reservation
            user.delete_reservation(chosen_reservation)
        else puts "Reservation not found."
        end
    end

end