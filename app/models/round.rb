class Round < ActiveRecord::Base
  attr_accessible :bid_suit, :bid_value, :bidding_team_won_round, :game_id, :number, :tricks_won_by_other_team, :winning_team_id
end
