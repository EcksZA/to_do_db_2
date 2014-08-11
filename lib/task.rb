require 'pg'
require 'pry'

class Task
  attr_accessor :name, :list_id, :id, :completed, :due_date

  def initialize(hash)
    @name = hash[:name]
    @list_id = hash[:list_id]
    @id = hash[:id]
    @completed = hash[:completed]
    @due_date = hash[:due_date]
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
      due_date = result['due_date']
      completed == 't' ? completed = true : completed = false
      tasks << Task.new({:name => name, :list_id => list_id, :id => id, :due_date => due_date, :completed => completed})
    end
    tasks
  end

  def save
    @completed = false
    results = DB.exec("INSERT INTO tasks (name, list_id, completed, due_date) VALUES ('#{@name}', #{@list_id}, '#{@completed}', '#{@due_date}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM tasks WHERE id = #{self.id};")
  end

  def done
    result = DB.exec("UPDATE tasks SET completed = '#{true}' WHERE id = #{self.id};")
  end

  def self.show_completed
    Task.all.select { |task| task.completed == true }
  end

  def self.sort_by_date(time)
    time == "soonest" ? results = DB.exec("SELECT * FROM tasks ORDER BY due_date ASC;") : results = DB.exec("SELECT * FROM tasks ORDER BY due_date DESC;")
    sort_by_date = []
    results.each do |result|
      name = result['name']
      due_date = result['due_date']
      list_id = result['list_id'].to_i
      sort_by_date << Task.new({:name => name, :due_date => due_date, :list_id => list_id})
    end
    sort_by_date
  end

  def edit(user_edit)
   DB.exec("UPDATE tasks SET name = '#{user_edit}' WHERE id = #{self.id};")
   self.name = user_edit
  end

end

