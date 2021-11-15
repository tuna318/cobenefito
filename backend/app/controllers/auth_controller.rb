class AuthController < ApplicationController
  before_action :authorize_request, only: [:profile]

  def login
    token, expire_time = AuthService.authenticate(params)
    render json: { token: token, expire_time: expire_time }, status: :ok
  end

  def profile
    current_user_info = @current_space_user.as_json.except(
      "user_password_digest"
    )
    render json: current_user_info, status: :ok
  end
end
