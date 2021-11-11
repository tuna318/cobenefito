module Manager
  class CouponsController < ApplicationController
    before_action :authorize_manager_request

    def create
      Manager::CouponsService.create(@current_space, register_coupons_param)

      render json: {}, status: :created
    end

    def index
      coupons = Manager::CouponsService.index(@current_space)

      render json: coupons, status: :ok
    end

    def distribute
      Manager::CouponsService.distribute(@current_space, distribute_coupons_params)

      render json: {}, status: :ok
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

    def distribute_coupons_params
      params.permit(
        :name,
        :usuable_at,
        :usuable_for,
        :expire_at,
        :value,
        user_ids: []
      )
    end
  end
end
