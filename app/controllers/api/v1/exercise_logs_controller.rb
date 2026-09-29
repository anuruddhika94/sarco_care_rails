module Api
  module V1
    class ExerciseLogsController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        render json: patient.exercise_logs.includes(:exercise).order(completed_on: :desc)
      end

      def create
        patient = acting_patient
        return unless patient

        log = patient.exercise_logs.new(exercise_log_params)
        log.completed_on ||= Date.current
        if log.save
          render json: log, status: :created
        else
          render json: { error: log.errors.full_messages.to_sentence, errors: log.errors }, status: :unprocessable_entity
        end
      end

      private

      def exercise_log_params
        params.permit(:exercise_id, :completed_on, :minutes)
      end
    end
  end
end
