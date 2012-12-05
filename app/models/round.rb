class Round < ActiveRecord::Base
  attr_accessible :bid_suit, :bid_value, :bidding_team_won_round, :number, :tricks_won_by_other_team

  belongs_to :game
  belongs_to :bid_player, :class_name => "Player"
  has_many :scores
end
