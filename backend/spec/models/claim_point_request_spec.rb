require 'rails_helper'

RSpec.describe ClaimPointRequest, type: :model do
  describe "Associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user) }
  end
end
