require 'pg'
require './lib/task'
require './lib/list'
require 'pry'

DB = PG.connect(:dbname => 'to_do_base')

@current_list = nil

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

  puts "\n#{new_list.name} successfully saved, returning to the main menu.\n\n"
  main_menu
end

def view_lists
  List.all.each_with_index do |list, index|
    puts "#{index+1}. #{list.name}"
  end

  puts "Please select from the following:"
  puts "Press 'd' to delete a list, 't' to go to edit a list's tasks,"
  puts "or any other key to return to menu"
  user_choice = gets.chomp

  if user_choice == 'd'
    delete_list
  elsif user_choice == 't'
    task_menu
  else
    main_menu
  end
end

def delete_list
  puts "Which list must meet its demise??"
  user_input = gets.chomp
  List.all.each do |list|
    if list.name == user_input
      list.delete
    end
  end
  main_menu
end

def task_menu
 puts "Welcome to the task menu. Which list would you like to look at?"
 user_input = gets.chomp

 List.all.each do |list|
  puts "\nYou've selected #{list.name}.\n"
 end
 List.all.each do |list|
    if list.name == user_input
      @current_list = list
      puts @current_list.name
      Task.all.each do |task|
        puts task.name
      end
    end
  end
  puts "What would you like to do with #{@current_list.name}?"
  puts "Press 'a' to add a task, 'l' to list all tasks,"
  puts "'d' to delete a task, 'c' to mark a task as complete, or"
  puts "'x' to exit to main menu."

  user_choice = gets.chomp
  if user_choice == 'a'
    add_task
  elsif user_choice == 'd'
    destroy_task
  elsif user_choice == 'l'
    list_tasks
  elsif user_choice == 'c'
    complete_task
  elsif user_choice == 'x'
    main_menu
  elsif user_choice == 'q'
    puts "\n\n\nOH BY ALL THE GODS ABOVE AND BELOW, WHY DID YOU PRESS Q? YOU'VE DOOMED US ALL\n\n\n"
    main_menu
  else
    puts "Please try again. You are a smart and wonderful person, and clearly by no fault of your own entered a letter not on the list of options we prescribed. We're sorry... we'll do better next time.\n"
    task_menu
  end


end

def add_task
  puts "What task would you like to add to #{@current_list.name}?"
  input_task = gets.chomp
  new_task = Task.new(input_task, @current_list.id)
  new_task.save

  puts "#{new_task.name} successfully added to #{@current_list.name}"
  puts "Would you like to add another? y/n"
  user_choice = gets.chomp
  if user_choice == 'y'
    add_task
  else
    puts "No worries, returning to task menu"
    task_menu
  end
end

def list_tasks
  puts "Here are all of your tasks for #{@current_list.name}"

  @current_list.tasks

  puts "\n\n"
  main_menu
end


welcome





