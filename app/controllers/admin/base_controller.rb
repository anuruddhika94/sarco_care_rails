module Admin
  # Session-based (not JWT) auth, separate from the mobile app's API.
  class BaseController < ActionController::Base
    layout "admin"
    protect_from_forgery with: :exception

    # API-only mode skips Rails' usual "include every app/helpers module
    # into every controller's views" wiring, so it's declared explicitly.
    helper AdminHelper

    before_action :require_admin

    helper_method :current_admin

    private

    def current_admin
      @current_admin ||= AdminUser.find_by(id: session[:admin_id])
    end

    def require_admin
      return if current_admin

      redirect_to admin_login_path, alert: "Please log in to continue."
    end
  end
end
