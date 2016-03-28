class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :sport
  has_many :users_teams
  has_many :users, :through => :users_teams
end