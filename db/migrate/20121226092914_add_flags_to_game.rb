class AddFlagsToGame < ActiveRecord::Migration
  def change
    add_column :games, :allow_slams, :boolean, :default => true
    add_column :games, :cap_non_bidding_tricks, :boolean, :default => true
  end
end
