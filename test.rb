require 'pry'
require "tty-prompt"
prompt = TTY::Prompt.new

def cuisine_type
    puts "What would you like to eat today?"
    food = gets.chomp
end

binding.pry
0