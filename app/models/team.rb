class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :memberships
  has_many :players, :through => :memberships

  has_many :participations
  has_many :games, :through => :participations

  has_many :scores
end
