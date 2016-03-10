class User < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :teams
end
