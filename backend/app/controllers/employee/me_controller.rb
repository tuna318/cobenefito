module Employee
  class MeController < ApplicationController
    before_action :authorize_employee_request

    def index
      current_user_info = @current_space_user.as_json.except(
        "user_password_digest",
        "user_role"
      )
      render json: current_user_info, status: :ok
    end
  end
end
