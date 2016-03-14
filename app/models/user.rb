require 'digest'
class User < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :teams

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
