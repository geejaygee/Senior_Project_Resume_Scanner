class Job < ActiveRecord::Base
  mount_uploader :attachment, JobAttachmentUploader
  validates :filename, presence: true
  validates :position, presence: true
  belongs_to :employer
end
