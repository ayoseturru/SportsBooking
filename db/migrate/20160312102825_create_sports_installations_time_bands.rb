class CreateSportsInstallationsTimeBands < ActiveRecord::Migration
  def change
    create_table :sports_installations_time_bands do |t|
      t.boolean :free
      t.belongs_to :time_band, index: {name: "intermediate_tb"}
      t.belongs_to :sports_installation, {name: "intermediate_si"}
      t.timestamps null: false
    end
  end
end
