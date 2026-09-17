module Api
  module V1
    class RemindersController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        render json: patient.reminders.order(:kind)
      end

      def update
        patient = acting_patient
        return unless patient

        reminder = patient.reminders.find(params[:id])
        reminder.update!(enabled: params[:enabled])
        render json: reminder
      end
    end
  end
end
