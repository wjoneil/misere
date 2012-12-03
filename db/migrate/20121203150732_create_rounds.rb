class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :number
      t.integer :bid_value, :null => true
      t.string :bid_suit, :null => true
      t.boolean :bidding_team_won_round, :null => true
      t.integer :tricks_won_by_other_team, :null => true
      t.integer :bid_player_id
      t.integer :game_id

      t.timestamps
    end
  end
end
