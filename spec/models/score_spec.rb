require 'spec_helper'

describe Score do

  describe "the bid lookup table" do

    it "raises an error on an invalid bid" do
      lambda { Score.lookup_points("6", "fail") }.should raise_error(Score::ScoreDoesNotExist)
      lambda { Score.lookup_points("11", "spades") }.should raise_error(Score::ScoreDoesNotExist)
    end

    it "identifies misere" do
      expect(Score.lookup_points("0", "misere")).to be(250)
    end

    it "identifies open misere" do
      expect(Score.lookup_points("0", "open misere")).to be(500)
    end

  end

end
