class TeamPlayerValidator < ActiveModel::Validator
  def validate(record)

    if record.players.length != 2
      record.errors[:base] << "A team must have two players"
    end

    if record.players.first.eql? record.players.last
      record.errors[:base] << "Players can't be the same"
    end
  end
end
