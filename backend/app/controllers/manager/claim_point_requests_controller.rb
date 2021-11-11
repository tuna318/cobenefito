module Manager
  class ClaimPointRequestsController < ApplicationController
    before_action :authorize_manager_request

    def index
      claim_point_requests = Manager::ClaimPointRequestsService.index(@current_space)

      render json: claim_point_requests, status: :ok
    end

    def update
      # index
    end
  end
end
