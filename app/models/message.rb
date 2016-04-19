class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content, :user_id, :sender
  before_create :set_date, :set_visibility

  private
  def set_visibility
    self.show_recipient = true
    self.show_sender = true
  end

  private
  def set_date
    self.date = Time.now
  end
end
