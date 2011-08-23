class LiveClass < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  validates_presence_of :url
  has_many :notes
end
