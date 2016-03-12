class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :sports_installation_id
      t.integer :time_band_id

      t.timestamps null: false
    end
  end
end
