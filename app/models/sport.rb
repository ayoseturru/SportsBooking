class Sport < ActiveRecord::Base
  has_many :installations, dependent: :destroy
end
