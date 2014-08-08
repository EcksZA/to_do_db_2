require 'spec_helper'
require 'pry'

describe Task do
  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it 'is initialized with a name and task ID' do
    task = Task.new({:name => 'learn how to surf', :id => 1})
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new({:name => 'learn how to surf', :id => 1})
    expect(task).to eq task
  end

  it 'tells you its list ID' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id})
    expect(task.list_id).to eq test_list.id
  end

  it 'lets you save tasks to the database' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id})
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new({:name => 'learn how to surf', :id => 1})
    task2 = Task.new({:name => 'learn how to surf', :id => 1})
    expect(task1).to eq task2
  end

  it 'deletes a task' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id})
    task.save
    task.delete
    expect(Task.all).to eq []
  end

  it 'marks a task as done' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id})
    task.save
    task.done
    expect(Task.all.first.completed).to eq true
  end
end
