module Employee
  class CouponsExchangeController < ApplicationController
    before_action :authorize_employee_request

    def index
      coupons = Employee::CouponsExchangeService.index(@current_space)

      render json: coupons, status: :ok
    end

    def create
      Employee::CouponsExchangeService.create(@current_space, @current_user, create_params)

      render json: {}, status: :ok
    end

    def purchase
      Employee::CouponsExchangeService.purchase(
        @current_space,
        @current_space_user,
        purchase_params
      )

      render json: {}, status: :ok
    end

    private

    def create_params
      params.permit(:price, :coupon_id)
    end

    def purchase_params
      params.permit(:tx_id)
    end
  end
end
