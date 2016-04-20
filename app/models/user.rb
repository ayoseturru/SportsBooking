require 'digest'
class User < ActiveRecord::Base
  has_many :bookings, dependent: :destroy
  has_many :users_teams
  has_many :messages
  has_many :comments
  has_many :teams, :through => :users_teams
  has_attached_file :image, styles: {large: "600*600>", medium: "300x300>", thumb: "125x125>"}, default_url: "/default_profile.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

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
