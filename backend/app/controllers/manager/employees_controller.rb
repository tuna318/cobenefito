module Manager
  class EmployeesController < ApplicationController
    before_action :authorize_manager_request
    # temporary method for user registration
    def create
      Manager::EmployeesService.create(@current_space, register_employee_params)

      render json: {}, status: :created
    end

    def register_employee_params
      params.permit(:email, :password)
    end
  end
end
