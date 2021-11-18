module Manager
  class ClaimPointsRequestsService
    class << self
      def index(space)
        points_claims = space.claim_point_requests.order(created_at: :DESC)
        points_claims.map { |points_claim| points_claim_response(points_claim) }
      end

      def update(space, params)
        request = space.claim_point_requests.find_by!(id: params[:id], status: "pending")

        handle_reject_update(request) if params[:status] == 'rejected'
        handle_approve_update(space, request, params) if params[:status] == 'approved'
      end

      private

      def points_claim_response(points_claim)
        space_user = points_claim.space.spaces_users.find_by(user_id: points_claim.user_id)
        response = points_claim.as_json
        response[:username] = space_user.username
        response[:user_email] = points_claim.user.email
        response[:user_claimable_points] = space_user.user_claimable_points
        response
      end

      def handle_reject_update(request)
        request.status = 'rejected'
        request.save!
      end

      def handle_approve_update(space, request, params)
        claimed_user = SpacesUser.find_by!(space_id: space.id, user_id: params[:user_id])
        claimable_points = claimed_user.user_claimable_points

        added_points = if claimable_points >= params[:claim_points]
                         params[:claim_points]
                       else
                         claimable_points
                       end
        claimed_user.user_reward_points += added_points
        claimed_user.user_claimable_points -= added_points
        request.status = 'approved'
        request.claim_points = added_points

        SpacesUser.transaction do
          claimed_user.save!
          request.save!
        end
      end
    end
  end
end
