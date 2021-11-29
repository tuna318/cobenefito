require 'rails_helper'

RSpec.describe CouponTransaction, type: :model do
  describe "associations" do
    it { should belong_to(:space) }
    it { should belong_to(:coupon) }
  end

  describe "validations" do
    it { should validate_presence_of(:price) }
  end
end
