class CouponTransaction < ApplicationRecord
  belongs_to :space
  belongs_to :coupon

  validates :price, presence: true
end
