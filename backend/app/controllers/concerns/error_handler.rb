module ErrorHandler
  extend ActiveSupport::Concern
  def self.included(base)
    base.class_eval do
      rescue_from ActiveRecord::RecordNotFound do |e|
        respond(:record_not_found, 404, e.to_s)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        respond(:unprocessable_entity, 422, e.to_s)
      end

      rescue_from JWT::VerificationError do
        respond(:unauthorized, 401, 'Unauthorized')
      end

      rescue_from CustomErrors::Unauthorized do
        respond(:unauthorized, 401, 'Unauthorized')
      end

      rescue_from CustomErrors::RecordExisted do |e|
        respond(:unprocessable_entity, 422, e.to_s)
      end

      rescue_from CustomErrors::CouponNumberLessThanEmployeeNumber do |e|
        respond(:unprocessable_entity, 422, e.to_s)
      end

      rescue_from CustomErrors::CouponNotAvailable do |e|
        respond(:record_not_found, 404, e.to_s)
      end

      rescue_from CustomErrors::NotEnoughRewardPoints do |e|
        respond(:unprocessable_entity, 422, e.to_s)
      end

      rescue_from CustomErrors::ReferenceLinkSumitted do |e|
        respond(:unprocessable_entity, 422, e.to_s)
      end

      rescue_from ArgumentError do |e|
        respond(:unprocessable_entity, 422, e.to_s)
      end
    end
  end

  def respond(error, status, message)
    json = { error: error, status: status, message: message  }
    render json: json, status: status
  end
end
