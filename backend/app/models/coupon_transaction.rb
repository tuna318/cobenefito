class CouponTransaction < ApplicationRecord
  belongs_to :space
  belongs_to :coupon
end
