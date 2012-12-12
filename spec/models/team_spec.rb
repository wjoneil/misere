require 'spec_helper'

describe Team do

  let(:player1) { Player.new(name: "Player 1") }
  let(:player2) { Player.new(name: "Player 2") }
  let(:team) { Team.new(name: "Team 1") }
  let(:team2) { Team.new(name: "Team 2") }

  describe "model" do

    it "saves new teams" do
      team.players << player1 << player2
      result = team.save
      expect(result).to be true
    end

    it "won't save a team with fewer than two players" do
      result = team.save
      expect(result).to_not be true
    end

    it "won't save teams with two duplicated players" do
      team.players << player1 << player1
      result = team.save
      expect(result).to raise_error
    end

    it "won't save a team with a duplicated name" do
      team.players << player1 << player2
      team.save!
      team2 = Team.new(name: "Team 1")
      team2.players << player1 << player2
      result = team2.save
      expect(result).to raise_error
    end

  end

  describe "membership" do

    before(:each) do
      team.players << player1 << player2
      team.save!
    end

    it "can see its players" do
      team.players.length.should be(2)
    end

    it "doesn't delete players when disbanding" do
      player1.teams.length.should be(1)

      team.destroy

      Team.all.should be_empty
      Membership.all.should be_empty

      #need to reload player here apparently?
      player1 = Player.first!

      player1.teams.should be_empty

    end

  end

end
