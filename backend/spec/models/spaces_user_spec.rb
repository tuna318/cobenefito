require 'rails_helper'

RSpec.describe SpacesUser, type: :model do
  describe "Associations" do
    it { should belong_to(:space) }
    it { should belong_to(:user) }
  end
end
