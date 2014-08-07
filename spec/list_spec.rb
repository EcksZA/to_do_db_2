require 'spec_helper'

describe List do
  it 'is initialized with a name' do
    list = List.new('Epicodus stuff')
    expect(list).to be_an_instance_of List
  end

  it 'tells you its name' do
    list = List.new('Epicodus stuff')
    expect(list.name).to eq 'Epicodus stuff'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new('Epicodus stuff')
    list2 = List.new('Epicodus stuff')
    expect(list1).to eq list2
  end

  it 'starts off with no lists' do
    expect(List.all).to eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('Epicodus stuff')
    list.save
    expect(List.all).to eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new('Epicodus stuff')
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end

  it 'deletes a list' do
    list = List.new('chattel')
    list.save
    list.delete
    expect(List.all).to eq []
  end
end
