class Installation < ActiveRecord::Base
  has_many :sports, dependent: :destroy
end
