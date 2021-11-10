class User < ApplicationRecord
  has_many :spaces_users
  has_many :spaces, through: :spaces_users
  has_many :claim_point_requests
  has_many :coupons
  has_many :coupon_transactions

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
end
