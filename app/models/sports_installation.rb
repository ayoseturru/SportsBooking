class SportsInstallation < ActiveRecord::Base
  has_many :sports_installations_time_bands
  has_many :time_bands, :through => :sports_installations_time_bands
  has_one :installation
  has_one :sport
end
