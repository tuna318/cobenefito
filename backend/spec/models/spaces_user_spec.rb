require 'rails_helper'

RSpec.describe SpacesUser, type: :model do
  describe "associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should have_secure_password(:user_password) }
    it { should validate_presence_of(:user_password_digest) }
    it { should define_enum_for(:user_role).with_values([:manager, :employee]) }
    it { should allow_value(nil).for(:user_claimable_points) }
    it { should allow_value(nil).for(:user_reward_points) }
  end

  describe "association on creation" do
    let(:user) { build_stubbed(:user) }
    let(:space) { build_stubbed(:space) }
    subject { spaces_user.save! }

    context "full association" do
      let(:spaces_user) { build(:employee, user: user, space: space) }

      it { expect { subject }.not_to raise_error }
    end

    context "lack of user association" do
      let(:spaces_user) { build(:employee, user: nil, space: space) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context "lack of space association" do
      let(:spaces_user) { build(:employee, user: user, space: nil) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
