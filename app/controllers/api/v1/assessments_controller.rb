module Api
  module V1
    class AssessmentsController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        render json: patient.assessments.order(completed_at: :desc)
      end

      def create
        patient = acting_patient
        return unless patient

        assessment = patient.assessments.new(answers: params[:answers], completed_at: Time.current)
        if assessment.save
          render json: assessment, status: :created
        else
          render json: { error: "Validation failed", errors: assessment.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
