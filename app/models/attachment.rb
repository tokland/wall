class Attachment < ActiveRecord::Base
  has_attached_file :asset, :url => "/system/:class/:attachment/:id/:filename"
  belongs_to :note
end
