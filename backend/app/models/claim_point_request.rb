class ClaimPointRequest < ApplicationRecord
  belongs_to :space
  belongs_to :user

  enum status: { pending: 0, rejected: 1, approved: 2 }

  validates :status, inclusion: { in: statuses }
  validates :title, presence: true
  validates :preference_link, presence: true
end
