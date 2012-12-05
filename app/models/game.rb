class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :teams, :through => :participations
  has_many :players, :through => :teams
  has_many :rounds
  has_many :scores
end
