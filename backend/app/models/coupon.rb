class Coupon < ApplicationRecord
  belongs_to :space
  belongs_to :user
  has_many :coupon_transactions

  enum type: { shopping: 0, travel: 1, food: 2, health: 3 },
       unit: { dollar: 0, vnd: 1, yen: 2 },
       status: { available: 0, on_sale: 1, used: 2 }
end
