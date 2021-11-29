require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user).optional }
    it { should have_many(:coupon_transactions) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code).case_insensitive }
    it { should validate_presence_of(:usuable_at) }
    it { should define_enum_for(:usuable_for).with([:shopping, :travel, :food, :health]) }
    it { should validate_presence_of(:value) }
    it { should define_enum_for(:unit).with([:dollar, :vnd, :yen]) }
    it { should define_enum_for(:status).with([:available, :on_sale, :used]) }
  end
end
