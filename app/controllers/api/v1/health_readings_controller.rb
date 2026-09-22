module Api
  module V1
    class HealthReadingsController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        render json: patient.health_readings.order(recorded_on: :desc)
      end

      # One reading per date: posting again for a date that already has a
      # reading updates it instead of creating a duplicate.
      def create
        patient = acting_patient
        return unless patient

        reading = patient.health_readings.find_or_initialize_by(recorded_on: params[:recorded_on])
        was_new = reading.new_record?
        reading.assign_attributes(health_reading_params.except(:recorded_on))
        if reading.save
          render json: reading, status: was_new ? :created : :ok
        else
          render json: { error: reading.errors.full_messages.to_sentence, errors: reading.errors }, status: :unprocessable_entity
        end
      end

      private

      def health_reading_params
        params.permit(:recorded_on, :weight_kg, :height_cm, :calf_cm)
      end
    end
  end
end
