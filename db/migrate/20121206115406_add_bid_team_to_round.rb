class AddBidTeamToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :bid_team, :integer
  end
end
