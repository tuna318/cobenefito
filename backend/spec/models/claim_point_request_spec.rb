require 'rails_helper'

RSpec.describe ClaimPointRequest, type: :model do
  describe "associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should define_enum_for(:status).with_values([:pending, :rejected, :approved]) }
    it { should validate_presence_of(:title) }
    it { should allow_value("http://example.com").for(:reference_link) }
    it { should_not allow_value("fpt://example.com").for(:reference_link) }
  end

  describe "association on creation" do
    let(:space) { build_stubbed(:space) }
    let(:user) { build_stubbed(:user) }
    subject { claim_point_request.save! }

    context "full association" do
      let(:claim_point_request) { build(:claim_point_request, space: space, user: user) }

      it { expect { subject }.not_to raise_error }
    end

    context "lack of user association" do
      let(:claim_point_request) { build(:claim_point_request, space: space, user: nil) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context "lack of space association" do
      let(:claim_point_request) { build(:claim_point_request, space: nil, user: user) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
