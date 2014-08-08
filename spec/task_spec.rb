require 'spec_helper'
require 'pry'

describe Task do
  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it 'is initialized with a name and task ID' do
    task = Task.new('learn SQL', 1)
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('learn SQL', 1)
    expect(task).to eq task
  end

  it 'tells you its list ID' do
    task = Task.new('learn SQL', 1)
    expect(task.list_id).to eq 1
  end

  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL', 1)
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new('learn SQL', 1)
    task2 = Task.new('learn SQL', 1)
    expect(task1).to eq task2
  end

  it 'deletes a task' do
    task = Task.new('chattel', 1)
    task.save
    task.delete
    expect(Task.all).to eq []
  end

  it 'marks a task as done' do
    task = Task.new('learn how to surf', 1)
    task.save
    task.done
    expect(Task.all.first.name).to eq 'learn how to surf -- DONE'
  end
end
