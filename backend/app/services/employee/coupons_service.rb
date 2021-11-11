module Employee
  class CouponsService
    class << self
      def index(space, user)
        Coupon.where(space_id: space.id, user_id: user.id)
      end

      def update(space, user, params)
        # only allow employee to update coupon status
        coupon = Coupon.find_by!(id: params[:id], user_id: user.id, space_id: space.id)
        coupon.status = params[:status]
        coupon.save!
      end
    end
  end
end
