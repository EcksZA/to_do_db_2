require 'pg'
require 'pry'

class Task
  attr_accessor :name, :list_id, :id, :completed

  # def completed=(boolean)
  #   @completed = false
  # end

  def initialize(hash)
    @name = hash[:name]
    @list_id = hash[:list_id]
    @id = hash[:id]
    @completed = hash[:completed]
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end


  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      id = result['id'].to_i
      completed = result['completed']
      completed == 't' ? completed = true : completed = false
      tasks << Task.new({:name => name, :list_id => list_id, :id => id, :completed => completed})
    end
    tasks
  end

  def save
    @completed = false
    results = DB.exec("INSERT INTO tasks (name, list_id, completed) VALUES ('#{@name}', #{@list_id}, '#{@completed}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM tasks WHERE id = #{self.id};")
  end

  def done
    result = DB.exec("UPDATE tasks SET completed = '#{true}' WHERE id = #{self.id};")
  end

end

