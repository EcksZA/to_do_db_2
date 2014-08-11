require 'spec_helper'
require 'pry'

describe Task do
  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it 'is initialized with a name and task ID' do
    task = Task.new({:name => 'learn how to surf', :id => 1, :due_date => '2014-08-10'})
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new({:name => 'learn how to surf', :id => 1, :due_date => '2014-08-10'})
    expect(task).to eq task
  end

  it 'tells you its list ID' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    expect(task.list_id).to eq test_list.id
  end

  it 'lets you save tasks to the database' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new({:name => 'learn how to surf', :id => 1, :due_date => '2014-08-10'})
    task2 = Task.new({:name => 'learn how to surf', :id => 1, :due_date => '2014-08-10'})
    expect(task1).to eq task2
  end

  it 'deletes a task' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    task.save
    task.delete
    expect(Task.all).to eq []
  end

  it 'marks a task as done' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    task.save
    task.done
    expect(Task.all.first.completed).to eq true
  end

  it 'shows the tasks that are marked as done' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    task.save
    task.done
    expect(Task.show_completed).to eq [task]
  end

  it "sorts the due date by the 'soonest due'" do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task_1 = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    task_1.save
    task_2 = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-02'})
    task_2.save
    task_3 = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-24'})
    task_3.save
    date = "soonest"
    expect(Task.sort_by_date(date)).to eq [task_2, task_1, task_3]
  end

  it "sorts the due date by the 'latest due'" do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task_1 = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-10'})
    task_1.save
    task_2 = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-02'})
    task_2.save
    task_3 = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-24'})
    task_3.save
    date = "latest"
    expect(Task.sort_by_date(date)).to eq [task_3, task_2, task_1]
  end

  it "allows the user to edit a task" do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    task = Task.new({:name => 'Debug the ruby OOP assessment', :list_id => test_list.id, :due_date => '2014-08-10'})
    task.save
    task.edit("I debugged it!")
    expect(task.name).to eq "I debugged it!"
  end
end
