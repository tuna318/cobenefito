module Employee
  class CouponsController < ApplicationController
    before_action :authorize_employee_request

    def index
      coupons = Employee::CouponsService.index(@current_space, @current_user)

      render json: coupons, status: :ok
    end

    def update
      Employee::CouponsService.update(@current_space, @current_user, update_coupon_params)

      render json: {}, status: :ok
    end

    private

    def update_coupon_params
      params.permit(:id, :status)
    end
  end
end
