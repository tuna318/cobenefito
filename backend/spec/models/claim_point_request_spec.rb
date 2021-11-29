require 'rails_helper'

RSpec.describe ClaimPointRequest, type: :model do
  describe "associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should define_enum_for(:status).with([:pending, :rejected, :approved]) }
    it { should validate_presence_of(:title) }
    it { should allow_value("http://example.com").for(:reference_link) }
    it { should_not allow_value("fpt://example.com").for(:reference_link) }
  end
end
