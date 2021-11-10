module Manager
  class CouponsController < ApplicationController
    before_action :authorize_manager_request

    def create
      Manager::CouponsService.create(@current_space, register_coupons_param)

      render json: {}, status: :created
    end

    private

    def register_coupons_param
      params.permit(
        :name,
        :usuable_at,
        :usuable_for,
        :expire_at,
        :value,
        codes: []
      )
    end
  end
end
