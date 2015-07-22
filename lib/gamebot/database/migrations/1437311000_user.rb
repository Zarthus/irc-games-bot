require 'sequel'

Sequel.migration do
  up do
    create_table :user do
      primary_key :id
      String :name
      String :host
      String :account
    end
  end

  down do
    drop_table :user
  end
end
