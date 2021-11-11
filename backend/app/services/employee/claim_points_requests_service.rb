module Employee
  class ClaimPointsRequestsService
    class << self
      def index(space, user)
        user.claim_point_requests
            .where(space_id: space.id)
            .order(created_at: :desc)
      end

      def create(space, user, params)
        if space.claim_point_requests
                .find_by(reference_link: params[:reference_link])
          raise CustomErrors::ReferenceLinkSumitted
        end

        user.claim_point_requests.create!(
          title: params[:title],
          status: "pending",
          reference_link: params[:reference_link],
          space_id: space.id
        )
      end
    end
  end
end
