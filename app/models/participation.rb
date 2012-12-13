class Participation < ActiveRecord::Base
  attr_accessible :winner

  belongs_to :game
  belongs_to :team

end
