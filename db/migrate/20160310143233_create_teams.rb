class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user_id
      t.integer :name
      t.string :sport

      t.timestamps null: false
    end
  end
end
