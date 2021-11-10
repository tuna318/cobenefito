module Manager
  class CouponsService
    class << self
      def create(space, params)
        Coupon.transaction do
          params[:codes].each { |code| create_coupon(space, params, code) }
        end
      end

      def index(space)
        space.coupons.find_by(status: 'avaiable')
      end

      private

      def create_coupon(space, coupon_info, code)
        Coupon.create!(
          {
            name: coupon_info[:name],
            usuable_at: coupon_info[:usuable_at],
            usuable_for: coupon_info[:usuable_for],
            expire_at: coupon_info[:expire_at],
            value: coupon_info[:value],
            unit: coupon_info[:unit] || 'dollar',
            status: 'available',
            space_id: space.id,
            code: code
          }
        )
      end
    end
  end
end
