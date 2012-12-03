class Participation < ActiveRecord::Base
  attr_accessible :game_id, :team_id, :winner
end
