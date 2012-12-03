require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  setup do
    @round = rounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create round" do
    assert_difference('Round.count') do
      post :create, round: { bid_suit: @round.bid_suit, bid_value: @round.bid_value, bidding_team_won_round: @round.bidding_team_won_round, game_id: @round.game_id, number: @round.number, tricks_won_by_other_team: @round.tricks_won_by_other_team, winning_team_id: @round.winning_team_id }
    end

    assert_redirected_to round_path(assigns(:round))
  end

  test "should show round" do
    get :show, id: @round
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @round
    assert_response :success
  end

  test "should update round" do
    put :update, id: @round, round: { bid_suit: @round.bid_suit, bid_value: @round.bid_value, bidding_team_won_round: @round.bidding_team_won_round, game_id: @round.game_id, number: @round.number, tricks_won_by_other_team: @round.tricks_won_by_other_team, winning_team_id: @round.winning_team_id }
    assert_redirected_to round_path(assigns(:round))
  end

  test "should destroy round" do
    assert_difference('Round.count', -1) do
      delete :destroy, id: @round
    end

    assert_redirected_to rounds_path
  end
end
