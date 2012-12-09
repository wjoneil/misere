class GameTeamValidator < ActiveModel::Validator
  def validate(record)

    if record.teams.length != 2
      record.errors[:base] << "A game must have two teams"
    end

    if record.teams.first.eql? record.teams.last
      record.errors[:base] << "Teams can't be the same"
    end
  end
end
