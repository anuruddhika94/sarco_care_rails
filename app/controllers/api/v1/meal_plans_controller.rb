module Api
  module V1
    class MealPlansController < ApplicationController
      def show
        render json: MealPlanDay.order(:day_number)
      end
    end
  end
end
