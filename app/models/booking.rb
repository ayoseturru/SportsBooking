class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :sports_installation
  belongs_to :time_band
  before_save :book_time_band, :set_teams
  before_destroy :free_time_band
  after_update :book_time_band
  scope :open_team_booking, -> { where.not(local_team: -1).where(away_team: -1) }
  scope :date, -> (date) { includes(:time_band).where('date = ?', date).references(:time_band) }

  def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end

  def sport
    self.sports_installation.sport.name
  end

  def start_hour
    self.time_band.end_hour
  end

  def local_team_name
    Team.find(self.local_team).name
  end

  def end_hour
    self.time_band.start_hour
  end

  def free_time_band
    SportsInstallationsTimeBand.where(time_band_id: self.time_band_id, sports_installation_id: self.sports_installation_id).first.update(free: true)
  end

  def book_time_band
    SportsInstallationsTimeBand.where(time_band_id: self.time_band_id, sports_installation_id: self.sports_installation_id).first.update(free: false)
  end

  def set_teams
    self.local_team ||= -1
    self.away_team ||= -1
  end

  private :free_time_band, :book_time_band, :set_teams

end
