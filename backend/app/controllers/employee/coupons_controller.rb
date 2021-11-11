module Employee
  class CouponsController < ApplicationController
    before_action :authorize_employee_request

    def index
      coupons = Employee::CouponsService.index(@current_space, @current_user)

      render json: coupons, status: :ok
    end
  end
end
