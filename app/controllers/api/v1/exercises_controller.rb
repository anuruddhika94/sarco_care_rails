module Api
  module V1
    class ExercisesController < ApplicationController
      def index
        render json: Exercise.order(:id)
      end
    end
  end
end
