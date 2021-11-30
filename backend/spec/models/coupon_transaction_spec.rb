require 'rails_helper'

RSpec.describe CouponTransaction, type: :model do
  describe "associations" do
    it { should belong_to(:space) }
    it { should belong_to(:coupon) }
  end

  describe "validations" do
    it { should validate_presence_of(:price) }
  end

  describe "association on creation" do
    let(:space) { build_stubbed(:space) }
    let(:coupon) { build_stubbed(:coupon) }
    subject { coupon_transaction.save! }

    context "full association" do
      let(:coupon_transaction) { build(:coupon_transaction, space: space, coupon: coupon) }

      it { expect { subject }.not_to raise_error }
    end

    context "lack of space association" do
      let(:coupon_transaction) { build(:coupon_transaction, space: nil, coupon: coupon) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context "lack of coupon association" do
      let(:coupon_transaction) { build(:coupon_transaction, space: space, coupon: nil) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
