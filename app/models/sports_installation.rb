class SportsInstallation < ActiveRecord::Base
  has_many :sports_installations_time_bands
  has_many :time_bands, :through => :sports_installations_time_bands
  belongs_to :installation
  belongs_to :sport
end
