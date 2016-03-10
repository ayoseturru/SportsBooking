class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.integer :max_players

      t.timestamps null: false
    end
  end
end
