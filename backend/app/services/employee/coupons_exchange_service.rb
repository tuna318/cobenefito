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

      def purchase(space, space_user, params)
        coupon_tx = CouponTransaction.find_by!(id: params[:tx_id], space_id: space.id)
        coupon = coupon_tx.coupon
        raise CustomErrors::CouponNotAvailable unless coupon.status == 'on_sale'
        raise CustomErrors::PurchaseOwneringCoupon if coupon.user_id == space_user.user_id
        raise CustomErrors::NotEnoughRewardPoints if space_user.user_reward_points < coupon_tx.price

        space_user.user_reward_points -= coupon_tx.price
        coupon_tx.buyer_id = space_user.user.id
        coupon.user_id = space_user.user.id
        coupon.status = :available

        Coupon.transaction do
          space_user.save!
          coupon_tx.save!
          coupon.save!
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
