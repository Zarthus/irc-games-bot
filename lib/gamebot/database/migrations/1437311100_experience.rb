require 'sequel'

Sequel.migration do
  up do
    create_table :experience do
      primary_key :id
      foreign_key :user_id, :user
      foreign_key :game_id, :game

      Integer :amount, default: 0
    end
  end

  down do
    drop_table :experience
  end
end
