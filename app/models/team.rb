class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :sport
  has_many :users_teams
  has_many :users, :through => :users_teams

  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end