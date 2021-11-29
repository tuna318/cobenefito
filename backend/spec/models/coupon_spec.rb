require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "Associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user).optional }
    it { should have_many(:coupon_transactions) }
  end
end
