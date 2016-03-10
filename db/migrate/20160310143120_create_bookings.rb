class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :sports_installation
      t.integer :time_band

      t.timestamps null: false
    end
  end
end
