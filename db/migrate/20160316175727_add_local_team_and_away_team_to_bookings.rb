class AddLocalTeamAndAwayTeamToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :local_team, :integer
    add_column :bookings, :away_team, :integer
  end
end
