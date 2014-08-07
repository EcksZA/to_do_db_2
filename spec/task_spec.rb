require 'spec_helper'

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

end
