module Employee
  class CouponsService
    class << self
      def index(space, user)
        coupons = Coupon.where(space_id: space.id, user_id: user.id)
        coupons.map { |coupon| coupon_response(coupon) }
      end

      def update(space, user, params)
        # only allow employee to update coupon status
        coupon = Coupon.find_by!(id: params[:id], user_id: user.id, space_id: space.id)
        coupon.status = params[:status]
        coupon.save!
      end

      private

      def coupon_response(coupon)
        response = coupon.as_json
        response[:exchange_price] = nil
        return response unless coupon.status == 'on_sale'

        coupon_tx = coupon.coupon_transactions.order(created_at: :desc).last
        response[:exchange_price] = coupon_tx.price
        response
      end
    end
  end
end
