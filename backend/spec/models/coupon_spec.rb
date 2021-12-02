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
    it { should define_enum_for(:usuable_for).with_values([:shopping, :travel, :food, :health]) }
    it { should validate_presence_of(:value) }
    it { should define_enum_for(:unit).with_values([:dollar, :vnd, :yen]) }
    it { should define_enum_for(:status).with_values([:available, :on_sale, :used]) }
  end

  describe "association on creation" do
    let(:space) { build_stubbed(:space) }
    let(:user) { build_stubbed(:user) }
    subject { coupon.save! }

    context "full association" do
      let(:coupon) { build(:coupon, space: space, user: user) }

      it { expect { subject }.not_to raise_error }
    end

    context "lack of user association" do
      let(:coupon) { build(:coupon, space: space, user: nil) }

      it { expect { subject }.not_to raise_error }
    end

    context "lack of space association" do
      let(:coupon) { build(:coupon, space: nil, user: user) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
