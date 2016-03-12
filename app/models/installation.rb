class Installation < ActiveRecord::Base
  has_and_belongs_to_many :sports, dependent: :destroy
  belongs_to :sports_installation
end
