module Employee
  class ClaimPointsRequestsController < ApplicationController
    before_action :authorize_employee_request

    def index
      requests = Employee::ClaimPointsRequestsService
                 .index(@current_space, @current_user)

      render json: requests, status: :ok
    end

    def create
      Employee::ClaimPointsRequestsService.create(
        @current_space,
        @current_user,
        create_params
      )

      render json: {}, status: :ok
    end

    private

    def create_params
      params.permit(:title, :reference_link)
    end
  end
end
