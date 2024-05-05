class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  private

  def not_found_response(exception)
    render json: ErrorSerializer.serialize_error(exception), status: :not_found
  end

  def invalid_response(exception)
    render json: ErrorSerializer.serialize_error(exception), status: :bad_request
  end
end
