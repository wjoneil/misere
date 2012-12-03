class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.boolean :winner
      t.integer :team_id
      t.integer :game_id

      t.timestamps
    end
  end
end
