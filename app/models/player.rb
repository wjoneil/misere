class Player < ActiveRecord::Base
  attr_accessible :name

  has_many :memberships
  has_many :teams, :through => :memberships
  has_many :games, :through => :teams

  validates :name, :presence => true, :uniqueness => true

end
