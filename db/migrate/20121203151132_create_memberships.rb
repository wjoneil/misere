class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :player_id
      t.integer :team_id

      t.timestamps
    end
  end
end
