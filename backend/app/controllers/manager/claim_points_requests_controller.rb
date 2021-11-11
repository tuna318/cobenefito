module Manager
  class ClaimPointsRequestsController < ApplicationController
    before_action :authorize_manager_request

    def index
      claim_point_requests = Manager::ClaimPointsRequestsService.index(@current_space)

      render json: claim_point_requests, status: :ok
    end

    def update
      Manager::ClaimPointsRequestsService.update(@current_space, update_params)
      render json: {}, status: :ok
    end

    private

    def update_params
      params.permit(:id, :status, :user_id, :claim_points)
    end
  end
end
