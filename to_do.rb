require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect(:dbname => 'to_do_base')

def welcome
  puts "Welcome to the To Do list \n\n"
  main_menu
end

def main_menu
  puts "Please select from the following:"
  puts "Press 'c' to create a new list, 'a' to add a task,"
  puts "'v' to view all lists, or 'x' to exit."

  user_choice = gets.chomp

  if user_choice == 'c'
    create_list
  elsif user_choice == "a"
    add_task
  elsif user_choice == "v"
    view_lists
  elsif user_choice == "x"
    puts "Ciao!"
    exit
  else
    main_menu
  end
end

def create_list
  puts "What would you like your list to be named?"

  user_list = gets.chomp
  new_list = List.new(user_list)
  new_list.save

  puts "\nPerfect, returning to the main menu.\n"
  main_menu
end

def view_lists
    List.all.each_with_index do |list, index|
    puts "#{index+1}. #{list.name}"
  end
end

# def add_task
#   puts "What do you need to do?"
#   task = gets.chomp
#   Task.new(task, )
# end


welcome





