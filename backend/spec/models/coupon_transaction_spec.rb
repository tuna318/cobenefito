require 'rails_helper'

RSpec.describe CouponTransaction, type: :model do
  describe "Associations" do
    it { should belong_to(:space) }
    it { should belong_to(:coupon) }
  end
end
