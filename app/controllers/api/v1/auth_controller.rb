module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user!, only: [:signup, :login]

      def signup
        user = User.new(signup_params)
        if user.save
          render json: { token: token_for(user), user: user }, status: :created
        else
          render json: { error: user.errors.full_messages.to_sentence, errors: user.errors }, status: :unprocessable_entity
        end
      end

      def login
        user = User.find_by(phone_number: params[:phone_number])
        unless user&.authenticate(params[:password])
          return render json: { error: "Invalid phone number or password" }, status: :unauthorized
        end

        if params[:role].present? && user.role != params[:role]
          return render json: { error: "This phone number is registered as a #{user.role}, not a #{params[:role]}" },
                        status: :unauthorized
        end

        render json: { token: token_for(user), user: user }
      end

      private

      def signup_params
        params.permit(:full_name, :phone_number, :email, :password, :password_confirmation, :role)
      end

      def token_for(user)
        JsonWebToken.encode({ user_id: user.id })
      end
    end
  end
end
