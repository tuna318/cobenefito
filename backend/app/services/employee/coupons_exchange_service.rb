module Employee
  class CouponsExchangeService
    class << self
      def index(space)
        coupons = space.coupons.where(status: "on_sale")

        coupons.map { |c| exchange_coupon_response(c) }
      end

      private

      def exchange_coupon_response(coupon)
        coupon_tx = coupon.coupon_transactions.order(created_at: :desc).last
        response = coupon.as_json
        response[:price] = coupon_tx.price
        response[:tx_id] = coupon_tx.id
        response[:owner_email] = coupon.user&.email
        response.except(:code)
      end
    end
  end
end
