module Manager
  class ClaimPointsRequestsService
    class << self
      def index(space)
        space.claim_point_requests.order(created_at: :DESC)
      end

      def update(space, params)
        request = space.claim_point_requests.find_by!(id: params[:id], status: "pending")

        handle_reject_update(request) if params[:status] == 'rejected'
        handle_approve_update(space, request, params) if params[:status] == 'approved'
      end

      private

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
