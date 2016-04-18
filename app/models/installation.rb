class Installation < ActiveRecord::Base
  has_and_belongs_to_many :sports, dependent: :destroy
  has_many :comments, :dependent => :destroy
end
