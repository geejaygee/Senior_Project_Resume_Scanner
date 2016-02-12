class ResumeDocument < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  validates :filename, presence: true
  belongs_to :user
end
