require_relative '../config/environment'
require 'tty-prompt'

choices = %w(ascending_price decreasing_price ascending_rating decreasing_rating ascending_reviews decreasing_reviews)
result = TTY::Prompt.new.select("Select an editor?", choices)
if result == "ascending_price"
    puts "this works"
elsif result == "decreasing_price"
    puts "2"
else
    puts "3"

end 

# puts "HELLO WORLD"