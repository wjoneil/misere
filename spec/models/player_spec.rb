require 'spec_helper'

describe Player do

  let(:player1) { Player.new(name: "Player 1") }
  let(:player2) { Player.new(name: "Player 2") }
  let(:team) { Team.new(name: "Team 1") }

  describe "model" do

    it "saves new players" do
      result = player1.save
      expect(result).to be true
    end

    it "won't save players with blank names" do
      blank_player = Player.new
      result = blank_player.save
      expect(result).to_not be true
    end

    it "won't save players with duplicated names" do
      player1.save!
      dup_player = Player.new(name: "Player 1")
      result = dup_player.save
      expect(result).to_not be true
    end

  end

  describe "team membership" do

    before(:each) do
      team.players << player1 << player2
      team.save!
    end

    it "can see its teams" do
      expect(player1.teams.length).to be(1)
    end

    it "is a symmetric relationship" do
      player1.teams.first().should eq(player2.teams.first())
    end

    #TODO: deleting a player also deletes their team

  end

end
