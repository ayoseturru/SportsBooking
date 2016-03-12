class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :sports_installation
  belongs_to :time_band
end
