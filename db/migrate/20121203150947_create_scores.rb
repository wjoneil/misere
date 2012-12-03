class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score, :null => true
      t.integer :team_id
      t.integer :round_id
      t.integer :game_id

      t.timestamps
    end
  end
end
