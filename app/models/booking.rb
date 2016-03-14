class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :sports_installation
  belongs_to :time_band
  before_save :book_time_band
  before_destroy :free_time_band

  def free_time_band
    SportsInstallationsTimeBand.where(time_band_id: self.time_band_id, sports_installation_id: self.sports_installation_id).first.update(free: true)
  end

  def book_time_band
    SportsInstallationsTimeBand.where(time_band_id: self.time_band_id, sports_installation_id: self.sports_installation_id).first.update(free: false)
  end

  private :free_time_band, :book_time_band
end
