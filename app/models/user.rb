require 'digest'
class User < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :users_teams
  has_many :messages
  has_many :comments
  has_many :teams, :through => :users_teams

  def self.authenticate(dni, password)
    user = find_by_dni(dni)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.password == encrypt(password)
  end

  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end
end
