class CreateSportsInstallations < ActiveRecord::Migration
  def change
    create_table :sports_installations do |t|
      t.integer :installation_id
      t.integer :sport_id

      t.timestamps null: false
    end
  end
end
