require 'rails_helper'

RSpec.describe "Spaces", type: :request do
  describe "POST /spaces" do
    let(:params) do
      {
        space: { name: "Space" },
        manager: {
          email: "hogehoge@gmail.com",
          username: "test",
          password: "12345678"
        }
      }
    end
    let(:create_space_request) { post spaces_path(params) }

    context "space not registered" do
      it "should create space successfully" do
        create_space_request
        expect(response).to have_http_status(:created) 
      end

      it "should add a new space to database" do
        number_of_spaces_before = Space.count
        create_space_request
        number_of_spaces_after = Space.count
        expect(number_of_spaces_after).to eq number_of_spaces_before + 1
      end
    end

    context "space already registered" do
      before { create(:space, name: params[:space][:name]) }

      it "should throw :unprocessable_entity" do
        create_space_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should not add a new space to database" do
        number_of_spaces_before = Space.count
        create_space_request
        number_of_spaces_after = Space.count
        expect(number_of_spaces_after).to eq number_of_spaces_before
      end
    end
  end
end
