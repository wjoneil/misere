class Player < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user

  has_many :memberships, :dependent => :destroy
  has_many :teams, :through => :memberships
  has_many :games, :through => :teams

  validates :name, :presence => true, :uniqueness => true

  def games_won
    games = teams.collect {|team| team.games_won}
    games.flatten
  end

  def bid_percentage team
    team.rounds_bid_on.where(bid_player_id: self.id).length / team.rounds_bid_on.length.to_f * 100
  end

  def win_percentage
    return 0 if games.empty?

    games_won.length / games.length.to_f * 100
  end

end
