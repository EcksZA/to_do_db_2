require 'spec_helper'
require 'pry'

describe List do
  it 'is initialized with a name' do
    list = List.new({:name => 'Epicodus Stuff'})
    expect(list).to be_an_instance_of List
  end

  it 'tells you its name' do
    list = List.new({:name => 'Epicodus Stuff'})
    expect(list.name).to eq 'Epicodus Stuff'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new({:name => 'Epicodus Stuff'})
    list2 = List.new({:name => 'Epicodus Stuff'})
    expect(list1).to eq list2
  end

  it 'starts off with no lists' do
    expect(List.all).to eq []
  end

  it 'lets you save lists to the database' do
    list = List.new({:name => 'Epicodus Stuff'})
    list.save
    expect(List.all).to eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new({:name => 'Epicodus Stuff'})
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end

  it 'deletes a list and all tasks associated' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    test_task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-23'})
    test_task.save
    test_list.delete
    expect(List.all).to eq []
    expect(Task.all).to eq []
  end

  it 'lists all the tasks in a particular list' do
    test_list = List.new({:name => 'Epicodus Stuff'})
    test_list.save
    test_task = Task.new({:name => 'learn how to surf', :list_id => test_list.id, :due_date => '2014-08-23'})
    test_task.save
    expect(test_list.tasks).to eq [test_task]
  end
end
