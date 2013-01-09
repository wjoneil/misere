class Team < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :name

  belongs_to :user

  has_many :memberships, :dependent => :destroy
  has_many :players, :through => :memberships

  has_many :participations
  has_many :games, :through => :participations
  has_many :games_won, :class_name => "Game", :foreign_key => "winning_team_id"

  has_many :rounds, :through => :games

  has_many :scores

  validates :name, :presence => true, :uniqueness => true
  validates_with TeamPlayerValidator

  before_destroy :destroy_games

  def games_actively_lost
    games.select {|game| !game.winning_team.id.eql?(self.id) && game.get_latest_scores[self.id] <= -500}
  end

  def rounds_bid_on
    rounds.where(bid_team_id: self.id)
  end

  def rounds_won
    rounds.where(bid_team_id: self.id).won
  end

  def scores_for_game game
    scores = [[0,0]]

    game.rounds.each do |round|
      unless round.scores.empty?
        score = round.scores.where(team_id: self.id).first()
        scores << [round.number, score.score]
      end
    end

    {
      label: self.name,
      data: scores
    }.to_json
  end

  def average_points_per_round

    return 0 if rounds.empty?

    points = rounds.collect { |round|
      if (round.bid_team_id.eql? self.id)
        round.calculate_points_for_bidders
      else
        round.tricks_won_by_other_team * 10
      end
    }

    (points.inject(:+).to_f / points.length).to_i

  end

  def win_percentage
    return 0 if games.empty?

    games_won.length / games.length.to_f * 100
  end

  def active_loss_percentage
    return 0 if games.empty?

    games_actively_lost.length / games.length.to_f * 100
  end

  def rounds_bid_on_percentage
    return 0 if rounds.empty?

    rounds_bid_on.length / rounds.length.to_f * 100
  end

  def rounds_bid_on_and_won_percentage
    return 0 if rounds.empty?

    rounds_won.length / rounds_bid_on.length.to_f * 100
  end

  def most_common_bids

    no_bids = {
      percentage: "",
      bids: []
    }

    return no_bids if rounds_bid_on.empty?

    bids = {}
    rounds_bid_on.each do |round|
      bids.merge!({"#{round.bid}" => 1}) { |key, oldval, newval| oldval + 1 }
    end

    max = bids.values.max

    max_bids = bids.select {|key, value| value.eql? max}

    {
      percentage: "#{(max / rounds_bid_on.length.to_f * 100).round}%",
      bids: max_bids.keys
    }

  end

  private

  # can't use :dependent => :destroy on :through => associations
  # but we want to disband the teams and delete the games
  def destroy_games
    games.each do |game|
      game.destroy
    end
  end

end
