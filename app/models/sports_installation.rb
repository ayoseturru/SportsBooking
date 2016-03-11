class SportsInstallation < ActiveRecord::Base
  has_many :time_bands
  has_one :installation
  has_one :sport
end
