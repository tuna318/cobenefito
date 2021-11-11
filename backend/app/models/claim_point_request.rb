class ClaimPointRequest < ApplicationRecord
  belongs_to :space
  belongs_to :user

  enum status: { pending: 0, rejected: 1, approved: 2 }

  validates :status, inclusion: { in: statuses }
  validates :title, presence: true
  validates :reference_link, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
end
