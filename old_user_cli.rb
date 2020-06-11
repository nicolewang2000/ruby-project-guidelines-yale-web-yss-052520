    # This may be for the CLI
    def self.new_or_returning?
        # prompt.yes?("Do you have an exsisting account?") ? (self.login_returning_user) : (self.create_username)

        # puts "Do you have an exsisting account?"
        # puts "[1] New User \n [2] Returning User"
        # ans = gets.chomp
        # if ans == "1"
        #     self.create_username
        # elsif ans == "2"
        #     self.login_returning_user
        # else
        #     self.new_or_returning?
        # end 
    end

    def self.new_user
        new_name = self.create_username
        new_username = self.create_name
        new_password = self.create_password
        User.create(name: new_name , username: new_username, password: new_password)
    end

    
    def self.create_username
        puts "Please enter a new username:"
        new_username = gets.chomp
        if User.find_by(username: new_username)
            puts "Sorry. This username is already taken."
            self.create_username
        end

    end

    def self.create_name
        puts "Please enter your first and last name:"
        new_name = gets.chomp.split.each {|name| name.capitalize!}.join(' ')
        # check to make sure both first and last names are entered
        if new_name.split.length != 2
            puts "Invalid response."
            self.create_name
        end
    end  

    def self.create_password
        puts "Please enter a password:"
        new_password = gets.chomp
         # new_passowrd = prompt.mask("Please enter a password", required: true)
    end

    # we may not need user zip code (can remove it from user db because we can ask for location and that input will be used to fetch the restartunt using the Api data)
    # def self.get_location
    #     puts "State your 5 number zip code:"
    #     new_location = gets.chomp
    #     if new_location.length != 5 
    #         self.get_location
    #     end
    #     self.new_user
    # end

    def self.login_returning_user
        puts "Please enter your username:"
        un = gets.chomp
        puts "Please enter your password: "
        pwd = gets.chomp
        find_user(un, pwd)
        # if User.find_by(username: un, password: pwd).nil? 
        #     if User.find_by(username: un).nil? 
        #         puts "This username does not exsist"
        #     else 
        #         puts "This password is incorrect"
        #     end 
        #     User.new_or_returning?
        # end
    end

    def find_user(un, pwd)
        if User.find_by(username: un, password: pwd).nil? 
            if User.find_by(username: un).nil? 
                puts "This username does not exist."
            else 
                puts "This password is incorrect."
            end 
            User.new_or_returning?
        end
    end

    def location
        puts "State your location:"
        place = gets.chomp
      end
      
      def cuisine_type
        puts "What would you like to eat today?"
        food = gets.chomp
      end
      