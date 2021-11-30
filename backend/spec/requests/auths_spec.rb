require 'rails_helper'

RSpec.describe "Auths", type: :request do
  before { register_space }

  describe "POST /auth/login" do
    let(:login_params) do
      {
        space_name: "space",
        user_email: "hogehoge@gmail.com",
        user_password: "12345678"
      }
    end
    let(:send_login_request) { post auth_login_path(login_params) }

    context "with valid credentials" do
      before { send_login_request }

      it "should return token & expire time" do
        expect(JSON.parse(response.body)).to include("token", "expire_time")
      end
    end

    context "with invalid credentials" do
      before do
        login_params[:user_password] = "123454321"
        send_login_request
      end

      it "should return 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
