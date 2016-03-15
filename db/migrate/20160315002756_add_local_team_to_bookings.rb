class AddLocalTeamToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :local_team, :integer
  end
end
