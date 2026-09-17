module Api
  module V1
    class HealthReadingsController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        readings = patient.health_readings.order(recorded_on: :desc)
        readings = readings.where(recorded_on: range_start(params[:range])..Date.current) if params[:range].present?
        render json: readings
      end

      def create
        patient = acting_patient
        return unless patient

        reading = patient.health_readings.new(health_reading_params)
        if reading.save
          render json: reading, status: :created
        else
          render json: { error: "Validation failed", errors: reading.errors }, status: :unprocessable_entity
        end
      end

      private

      def health_reading_params
        params.permit(:recorded_on, :weight_kg, :height_cm, :calf_cm)
      end

      def range_start(range)
        case range
        when "weekly" then 7.days.ago.to_date
        when "monthly" then 30.days.ago.to_date
        else Date.current
        end
      end
    end
  end
end
