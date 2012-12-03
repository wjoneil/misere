class Score < ActiveRecord::Base
  attr_accessible :game_id, :round_id, :score, :team_id
end
