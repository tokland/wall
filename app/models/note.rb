class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :live_class
  has_many :attachments
  
  validates_presence_of :user_id

  accepts_nested_attributes_for :attachments, :allow_destroy => true,
    :reject_if => lambda { |attachment_attributes| !attachment_attributes['asset'] }
    
  def state
    self.updated_at.to_i.to_s
  end    
end
