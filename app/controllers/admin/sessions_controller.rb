module Admin
  # Login only — admins have no signup; accounts are created via
  # db/seeds.rb or `bin/rails console`.
  class SessionsController < BaseController
    skip_before_action :require_admin, only: [ :new, :create ]
    layout "admin_auth"

    def new
      redirect_to admin_root_path if current_admin
    end

    def create
      admin = AdminUser.find_by(email: params[:email]&.downcase)
      if admin&.authenticate(params[:password])
        session[:admin_id] = admin.id
        redirect_to admin_root_path, notice: "Welcome back, #{admin.full_name}."
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:admin_id)
      redirect_to admin_login_path, notice: "Logged out."
    end
  end
end
