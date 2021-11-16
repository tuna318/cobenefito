module Manager
  class EmployeesController < ApplicationController
    before_action :authorize_manager_request
    # temporary method for user registration
    def create
      Manager::EmployeesService.create(@current_space, register_employee_params)

      render json: {}, status: :created
    end

    def index
      spaces_users = Manager::EmployeesService.index(@current_space, filter_employees_params)

      render json: spaces_users, status: :ok
    end

    def show
      employee, coupons = Manager::EmployeesService
                          .get_employee_details(@current_space, params[:id])

      render json: { employee: employee, coupons: coupons }, status: :ok
    end

    private

    def register_employee_params
      params.permit(:email)
    end

    def filter_employees_params
      params.permit(:username)
    end
  end
end
