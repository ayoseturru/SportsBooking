class CreateTimeBands < ActiveRecord::Migration
  def change
    create_table :time_bands do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
