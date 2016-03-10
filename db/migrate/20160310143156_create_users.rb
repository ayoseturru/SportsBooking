class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :dni
      t.string :name
      t.string :password

      t.timestamps null: false
    end
  end
end
