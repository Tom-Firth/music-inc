class Album < ApplicationRecord
  mount_uploader :cover, CoverUploader
  belongs_to :user

  validates :title, presence: true
end
