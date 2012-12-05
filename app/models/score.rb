class Score < ActiveRecord::Base
  attr_accessible :score

  belongs_to :game
  belongs_to :round
  belongs_to :team

  #TODO: remove game from score (can get it through round or team?)
end
