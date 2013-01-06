class Game < ActiveRecord::Base
  attr_accessible :winning_team, :allow_slams, :cap_non_bidding_tricks

  belongs_to :winning_team, :class_name => "Team"
  belongs_to :user

  has_many :participations, :dependent => :destroy
  has_many :teams, :through => :participations, :order => "participations.id asc"
  has_many :players, :through => :teams
  has_many :rounds, :dependent => :destroy
  has_many :scores

  validates_with GameTeamValidator

  def current_score
    get_latest_scores.values.join(" - ")
  end

  def get_latest_scores

    latest_scores = {}

    scores.latest.each do |score|
      latest_scores[score.team_id] = score.score
    end

    if latest_scores.empty?
      teams.each do |team|
        latest_scores[team.id] = 0
      end
    end

    latest_scores
  end

  def get_player_team_lookup

    player_team = {}

    teams.each do |team|

      team.players.each do |player|
        player_team[player.id] = team.id
      end

    end

    player_team

  end

  def completed?

    !!winning_team

  end

  def rounds_bid_on team
    rounds.where(bid_team_id: team.id)
  end

  def rounds_won team
    rounds.where(bid_team_id: team.id).won
  end

  def rounds_bid_on_percentage team
    return 0 if rounds.empty?

    rounds_bid_on(team).length / rounds.length.to_f * 100
  end

  def rounds_won_percentage team
    return 0 if rounds.empty?

    rounds_won(team).length / rounds_bid_on(team).length.to_f * 100
  end

  def determine_winner round
    score = round.scores.where(team_id: round.bid_team.id).first().score

    if (round.bidding_team_won_round && score >= 500)
      self.winning_team = round.bid_team
    end

    if (!round.bidding_team_won_round && score <= -500)
      self.winning_team = round.other_team
    end

  end

  def title
    created_at.strftime("%F: ") + teams.first().name + " vs " + teams.last().name
  end

end
