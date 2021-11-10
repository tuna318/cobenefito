class AuthController < ApplicationController
  def login
    token, expire_time = AuthService.authenticate(params)
    render json: { token: token, expire_time: expire_time }, status: :ok
  end
end
