require 'rails_helper'

RSpec.describe Space, type: :model do
  describe "Associations" do
    it { should have_many(:spaces_users) }
    it { should have_many(:users).through(:spaces_users) }
    it { should have_many(:coupons) }
    it { should have_many(:claim_point_requests) }
    it { should have_many(:coupon_transactions) }
  end
end
