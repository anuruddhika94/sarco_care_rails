class ApplicationController < ActionController::API
  include Authenticatable

  before_action :set_current_request_details

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable

  private

  # Lets User#avatar_url / MealPlanMeal#image build a URL against whatever
  # host this request actually came in on, rather than a hardcoded default
  # that's only reachable from some clients (see Current).
  def set_current_request_details
    Current.request_host = request.host
    Current.request_port = request.port
    Current.request_protocol = request.protocol
  end

  def render_not_found
    render json: { error: "Not found" }, status: :not_found
  end

  def render_unprocessable(exception)
    render json: { error: exception.message, errors: exception.record.errors }, status: :unprocessable_entity
  end
end
