class Team < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :name

  has_many :memberships, :dependent => :destroy
  has_many :players, :through => :memberships

  has_many :participations
  has_many :games, :through => :participations

  has_many :scores

  validates :name, :presence => true, :uniqueness => true
  validates_with TeamPlayerValidator

  before_destroy :check_participation

  private
  def check_participation
    games.length.eql? 0
  end

end
