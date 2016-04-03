class AddMaxSizeToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :max_size, :integer
  end
end
