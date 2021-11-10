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
    end
  end

  def respond(error, status, message)
    json = { error: error, status: status, message: message  }
    render json: json, status: status
  end
end
