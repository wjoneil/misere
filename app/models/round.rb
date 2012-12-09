class Round < ActiveRecord::Base
  attr_accessible :bid_suit, :bid_value, :bidding_team_won_round, :number, :tricks_won_by_other_team, :bid_team_id, :bid_player_id

  belongs_to :game
  belongs_to :bid_player, :class_name => "Player"
  belongs_to :bid_team, :class_name => "Team"
  has_many :scores, :order => "team_id ASC", :dependent => :destroy

  validates :bid_suit, :presence => true, :inclusion => { :in => ["spades", "clubs", "diamonds", "hearts", "no trumps", "misere", "open misere"] }
  validates :bid_value, :presence => true
  validates :bidding_team_won_round, :inclusion => { :in => [true, false] }
  validates :tricks_won_by_other_team, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10 }

  scope :descending, order("number DESC")

  def other_team
    game.teams.where("team_id != #{bid_team.id}").first()
  end

  def winning_team
    bid_team if bidding_team_won_round

    other_team
  end

  def bid
    bid_suit if bid_suit.include? "misere"
    "#{bid_value} #{bid_suit}"
  end

  def tricks_won_by_bidders
    10 - tricks_won_by_other_team
  end

  def score
    scores.first().score.to_s + " - " + scores.last().score.to_s
  end

  def calculate_scores

    latest_scores = game.get_latest_scores

    points = Score.lookup_points(bid_value, bid_suit)
    new_bid_team_score = latest_scores[bid_team.id] +=  (tricks_won_by_bidders >= bid_value ? points : 0 - points)
    new_other_team_score = latest_scores[other_team.id] += (tricks_won_by_other_team * 10)

    scores.build({score: new_bid_team_score, team_id: bid_team.id, game_id: game.id})
    scores.build({score: new_other_team_score, team_id: other_team.id, game_id: game.id})

  end


end
