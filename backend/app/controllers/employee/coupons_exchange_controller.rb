module Employee
  class CouponsExchangeController < ApplicationController
    before_action :authorize_employee_request

    def index
      coupons = Employee::CouponsExchangeService.index(@current_space)

      render json: coupons, status: :ok
    end
  end
end
