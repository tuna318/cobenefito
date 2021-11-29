require 'rails_helper'

RSpec.describe Space, type: :model do
  describe "associations" do
    it { should have_many(:spaces_users) }
    it { should have_many(:users).through(:spaces_users) }
    it { should have_many(:coupons) }
    it { should have_many(:claim_point_requests) }
    it { should have_many(:coupon_transactions) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
