require 'sequel'

Sequel.migration do
  up do
    create_table :game do
      primary_key :id
      String :name

      Integer :times_played, default: 0
    end
  end

  down do
    drop_table :game
  end
end
