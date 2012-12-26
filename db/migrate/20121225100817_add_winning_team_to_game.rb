class AddWinningTeamToGame < ActiveRecord::Migration
  def change
    add_column :games, :winning_team_id, :integer
  end
end
