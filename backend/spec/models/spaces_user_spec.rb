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
    it { should define_enum_for(:user_role).with([:manager, :employee]) }
    it { should allow_value(nil).for(:user_claimable_points) }
    it { should allow_value(nil).for(:user_reward_points) }
  end

  describe "on saving" do
    it "test saving"
  end
end
