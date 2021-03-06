class Score < ActiveRecord::Base
  attr_accessible :score, :team_id, :game_id

  belongs_to :game
  belongs_to :round
  belongs_to :team

  validates :score, :numericality => { :only_integer => true }

  scope :latest, order("round_id DESC, team_id ASC").limit(2)

  class ScoreDoesNotExist < StandardError; end

  def self.lookup_points(bid_value, bid_suit)

    return 250 if bid_suit.eql? "misere"
    return 500 if bid_suit.eql? "open misere"

    points = {
      "6"  => [40, 60, 80, 100, 120],
      "7"  => [140, 160, 180, 200, 220],
      "8"  => [240, 260, 280, 300, 320],
      "9"  => [340, 360, 380, 400, 420],
      "10" => [440, 460, 480, 500, 520]
    }

    suit_lookup = ["spades", "clubs", "diamonds", "hearts", "no trumps"]

    bid_value = bid_value.to_s

    raise ScoreDoesNotExist.new unless suit_lookup.include?(bid_suit) && points.keys.include?(bid_value)

    points[bid_value][suit_lookup.index(bid_suit)]

  end

end
