module Manager
  class ClaimPointRequestsService
    class << self
      def index(space)
        space.claim_point_requests.order("created_at DESC")
      end

      def update
        # todo
      end
    end
  end
end
