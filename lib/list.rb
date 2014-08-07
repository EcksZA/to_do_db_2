require 'pg'

class List
  attr_reader :name, :id

  def initialize(name)
    @name = name
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec('SELECT * FROM lists;')
    lists = []
    results.each do |result|
      name = result['name']
      lists << List.new(name)
    end
    lists
  end

  def delete
    DB.exec("DELETE FROM lists WHERE id = #{self.id};")
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end
end
