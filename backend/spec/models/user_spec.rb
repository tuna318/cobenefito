require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:spaces_users) }
    it { should have_many(:spaces).through(:spaces_users) }
    it { should have_many(:claim_point_requests) }
    it { should have_many(:coupons) }
  end

  it "is valid with valid attributes"

  it "is invalid with invalid email format"
end
