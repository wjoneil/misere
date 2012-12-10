class RoundScoreValidator < ActiveModel::Validator
  def validate(record)

    if record.scores.length != 2
      record.errors[:base] << "A round must record a score for each team"
    end

  end
end
