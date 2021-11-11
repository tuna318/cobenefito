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
end
