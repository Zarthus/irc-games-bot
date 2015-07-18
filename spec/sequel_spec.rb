require 'rspec'
require 'sequel'

describe 'Sequel Database Test' do
  it 'should be able to properly construct a database using SQLite' do
    dbh = Sequel.sqlite

    dbh.create_table :items do
      primary_key :id
      String :name
    end

    items = dbh[:items]

    items.insert(:name => 'A')
    items.insert(:name => 'B')
    items.insert(:name => 'C')

    expect(items.count).to eq(3)
    expect(items.where(:id => 1).first[:name]).to eq('A')
  end
end
