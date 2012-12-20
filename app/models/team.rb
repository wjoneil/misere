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

  def games_won
    games.where("participations.winner = 1")
  end

  def scores_for_game (game)
    data = [[0,0]]

    games.find(game.id).rounds.each do |round|
      score = round.scores.where(team_id: self.id).first()
      data << [round.number, score.score]
    end

    data
  end

  private
  def check_participation
    games.length.eql? 0
  end

end
