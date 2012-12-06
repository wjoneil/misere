class Game < ActiveRecord::Base
  has_many :participations, :dependent => :destroy
  has_many :teams, :through => :participations
  has_many :players, :through => :teams
  has_many :rounds, :dependent => :destroy
  has_many :scores

  def get_latest_scores

    latest_scores = {}

    scores.latest.each do |score|
      latest_scores[score.team_id] = score.score
    end

    latest_scores
  end

  def completed?

    latest_scores = get_latest_scores

    return false unless (latest_scores.length.eql? 2)

    latest_scores.each do |key, value|
      return true if value >= 500 || value <= -500
    end

    return false

  end

  def winner
    teams.where("participations.winner = true").first()
  end

  def title
    created_at.strftime("%F: ") + teams.first().name + " vs " + teams.last().name
  end



end
