class Team < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :name

  has_many :memberships
  has_many :players, :through => :memberships

  has_many :participations
  has_many :games, :through => :participations

  has_many :scores

  validates :name, :presence => true
  validates_with TeamPlayerValidator

end
