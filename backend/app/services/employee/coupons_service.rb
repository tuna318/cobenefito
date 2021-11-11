module Employee
  class CouponsService
    class << self
      def index(space, user)
        Coupon.where(space_id: space.id, user_id: user.id)
      end
    end
  end
end
