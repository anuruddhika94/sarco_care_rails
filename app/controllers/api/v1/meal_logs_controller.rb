module Api
  module V1
    class MealLogsController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        render json: patient.meal_logs.includes(meal_plan_meal: :meal_plan_items).order(eaten_on: :desc)
      end

      def create
        patient = acting_patient
        return unless patient

        log = patient.meal_logs.new(meal_log_params)
        log.eaten_on ||= Date.current
        if log.save
          render json: log, status: :created
        else
          render json: { error: log.errors.full_messages.to_sentence, errors: log.errors }, status: :unprocessable_entity
        end
      end

      private

      def meal_log_params
        params.permit(:meal_plan_meal_id, :eaten_on)
      end
    end
  end
end
