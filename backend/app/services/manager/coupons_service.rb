module Manager
  class CouponsService
    class << self
      def create(space, params)
        Coupon.transaction do
          params[:codes].each { |code| create_coupon(space, params, code) }
        end
      end

      def index(space)
        coupons = space.coupons.where(status: 'available', user_id: nil)
        coupon_groups = group_coupons(coupons)

        distinct_coupons_from_coupon_groups(coupon_groups)
      end

      def distribute(space, params)
        user_ids = params[:user_ids]
        return if user_ids.empty?

        distribute_coupons = get_distribute_coupons(space, params)
        if distribute_coupons.size < user_ids&.size
          raise CustomErrors::CouponNumberLessThanEmployeeNumber
        end

        # TODO: check user_id whether it belongs to space or not
        update_coupons = []
        (0...user_ids.size).each do |i|
          distribute_coupons[i].user_id = user_ids[i]
          update_coupons.push(distribute_coupons[i].as_json)
        end
        Coupon.upsert_all(update_coupons)
      end

      private

      def group_coupons(coupons)
        coupons.group_by do |c|
          c.name.itself || c.expire_at.itself || c.usuable_for.itself || c.value || c.usuable_at
        end
      end

      def distinct_coupons_from_coupon_groups(coupon_groups)
        distinct_coupons = []
        coupon_groups.each_value do |coupon_group|
          coupon = coupon_group[0].as_json
          coupon[:quantity] = coupon_group.size
          coupon = coupon.except("created_at", "updated_at", "user_id")
          distinct_coupons.push(coupon)
        end
        distinct_coupons
      end

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

      def get_distribute_coupons(space, params)
        space.coupons.where({
                              name: params[:name],
                              usuable_at: params[:usuable_at],
                              expire_at: params[:expire_at],
                              value: params[:value],
                              status: 'available',
                              user_id: nil
                            })
      end
    end
  end
end
