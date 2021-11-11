module Employee
  class CouponsExchangeService
    class << self
      def index(space)
        coupons = space.coupons.where(status: "on_sale")

        coupons.map { |c| exchange_coupon_response(c) }
      end

      def create(space, user, params)
        coupon = user.coupons.find_by!(id: params[:coupon_id], space_id: space.id)
        raise CustomErrors::CouponNotAvailable unless coupon.status == 'available'

        Coupon.transaction do
          coupon.status = 'on_sale'
          coupon.save!
          coupon.coupon_transactions.create!(
            price: params[:price],
            seller_id: user.id,
            space_id: space.id
          )
        end
      end

      private

      def exchange_coupon_response(coupon)
        coupon_tx = coupon.coupon_transactions.order(created_at: :desc).last
        response = coupon.as_json
        response[:price] = coupon_tx.price
        response[:tx_id] = coupon_tx.id
        response[:owner_email] = coupon.user&.email
        response.except("code")
      end
    end
  end
end
