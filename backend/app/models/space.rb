class Space < ApplicationRecord
  has_many :spaces_users
  has_many :users, through: :spaces_users
  has_many :coupons
  has_many :claim_point_requests
  has_many :coupon_transactions

  validates :name, presence: true
end
