class User < ActiveRecord::Base
  include Clearance::User 
  has_many :notes
  has_many :live_classes
  
  def name
    self.email.split("@").first
  end
end
