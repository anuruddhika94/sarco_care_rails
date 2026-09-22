module Api
  module V1
    class MeController < ApplicationController
      def show
        render json: current_user
      end

      def update
        if current_user.update(me_params)
          render json: current_user
        else
          render json: { error: current_user.errors.full_messages.to_sentence, errors: current_user.errors }, status: :unprocessable_entity
        end
      end

      private

      def me_params
        params.permit(:full_name, :email, :date_of_birth, :gender, :avatar, settings: {})
      end
    end
  end
end
