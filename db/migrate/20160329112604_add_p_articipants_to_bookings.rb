class AddPArticipantsToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :participants, :string
  end
end
