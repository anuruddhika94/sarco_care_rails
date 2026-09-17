module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  private

  def authenticate_user!
    render_unauthorized and return unless current_user
  end

  def current_user
    @current_user ||= begin
      payload = JsonWebToken.decode(bearer_token)
      User.find_by(id: payload && payload[:user_id])
    end
  end

  def bearer_token
    header = request.headers["Authorization"]
    header&.split(" ")&.last
  end

  def render_unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
