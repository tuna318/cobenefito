require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:spaces_users) }
    it { should have_many(:spaces).through(:spaces_users) }
    it { should have_many(:claim_point_requests) }
    it { should have_many(:coupons) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@gmail.com').for(:email) }
    it { should_not allow_value('user@gmail@com').for(:email) }
  end
end
