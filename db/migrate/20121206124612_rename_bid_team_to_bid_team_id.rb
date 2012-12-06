class RenameBidTeamToBidTeamId < ActiveRecord::Migration
  def change
    rename_column :rounds, :bid_team, :bid_team_id
  end
end
