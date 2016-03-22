class CreateUsersTeams < ActiveRecord::Migration
  def change
    create_table :users_teams do |t|
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
      t.timestamps null: false
    end
  end
end
