class SportsInstallationsTimeBand < ActiveRecord::Base
  belongs_to :sports_installation
  belongs_to :time_band
end
