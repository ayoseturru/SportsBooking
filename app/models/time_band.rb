class TimeBand < ActiveRecord::Base
  has_many :sports_installations, :through => :sports_installations_time_bands
  has_many :sports_installations_time_bands
end
