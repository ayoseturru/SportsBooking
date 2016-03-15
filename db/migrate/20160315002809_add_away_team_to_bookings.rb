class AddAwayTeamToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :away_team, :integer
  end
end
