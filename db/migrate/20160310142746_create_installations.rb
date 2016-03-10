class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.string :name
      t.string :address

      t.timestamps null: false
    end
  end
end
