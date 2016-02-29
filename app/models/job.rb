class Job < ActiveRecord::Base
  mount_uploader :attachment, JobAttachmentUploader
  validates :filename, presence: true
  validates :position, presence: true
  belongs_to :employer
  has_many :job_applications, dependent: :destroy
  accepts_nested_attributes_for :job_applications
end
