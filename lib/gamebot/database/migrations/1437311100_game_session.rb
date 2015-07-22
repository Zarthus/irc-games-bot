require 'sequel'

Sequel.migration do
  up do
    create_table :game_session do
      primary_key :id
      foreign_key :game_id, :game

      Integer :duration
      Integer :player_count
    end
  end

  down do
    drop_table :game_session
  end
end
