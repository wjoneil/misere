require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can create a round" do
    player1 = Player.new ({name: "a"})
    player2 = Player.new ({name: "b"})
    player3 = Player.new ({name: "c"})
    player4 = Player.new ({name: "d"})

    player1.save!
    player2.save!
    player3.save!
    player4.save!

    team1 = Team.new ({name: "one"})
    team1.players << player1
    team1.players << player2
    team1.save!

    team2 = Team.new ({name: "two"})
    team2.players << player3
    team2.players << player4
    team2.save!

    game = Game.new
    game.teams << team1
    game.teams << team2
    game.save!

    round = game.rounds.build ({
      game_id: game.id,
      bid_player_id: player1.id,
      bid_team_id: team1.id,
      bid_suit: "spades",
      bid_value: 6,
      number: 1,
      bidding_team_won_round: true,
      tricks_won_by_other_team: 0

    })

    round.calculate_scores

    game.save!

    assert_equal game.rounds.length, 1
  end
end
