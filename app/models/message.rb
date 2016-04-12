class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content, :user_id, :sender
  before_save :set_date

  private
  def set_date
    self.date = Time.now
  end
end
