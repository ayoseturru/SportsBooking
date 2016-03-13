class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :sports_installation
  belongs_to :time_band
  before_save :book_time_band


  private
  def book_time_band
    SportsInstallationsTimeBand.where(time_band_id: self.time_band_id, sports_installation_id: self.sports_installation_id).first.update(free: false)

  end
end
