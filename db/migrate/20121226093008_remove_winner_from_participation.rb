class RemoveWinnerFromParticipation < ActiveRecord::Migration
  def up
    remove_column :participations, :winner
  end

  def down
    add_column :participations, :winner, :boolean
  end
end
