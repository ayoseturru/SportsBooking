class Sport < ActiveRecord::Base
  has_and_belongs_to_many :installations, dependent: :destroy
end
