class Coupon < ApplicationRecord
  belongs_to :space
  belongs_to :user
  has_many :coupon_transactions

  enum usuable_for: { shopping: 0, travel: 1, food: 2, health: 3 },
       unit: { dollar: 0, vnd: 1, yen: 2 },
       status: { available: 0, on_sale: 1, used: 2 }

  validates :name, presence: true
  validates :code, presence: true
  validates :usuable_at, presence: true
  validates :usuable_for, inclusion: { in: usuable_fors }
  validates :value, presence: true
  validates :unit, inclusion: { in: units }
  validates :status, inclusion: { in: statuses }
end
