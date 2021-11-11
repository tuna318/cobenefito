module CustomErrors
  class Unauthorized < StandardError
  end

  class RecordExisted < StandardError
  end

  class CouponNumberLessThanEmployeeNumber < StandardError
    def initialize(msg = "Coupon number less than employee number")
      super
    end
  end

  class CouponNotAvailable < StandardError
    def initialize(msg = "Coupon not available")
      super
    end
  end

  class NotEnoughRewardPoints < StandardError
    def initialize(msg = "Not enough reward point")
      super
    end
  end
end
