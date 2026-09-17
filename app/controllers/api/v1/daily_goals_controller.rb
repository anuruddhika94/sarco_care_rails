module Api
  module V1
    class DailyGoalsController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        goals = patient.daily_goal_completions.order(date: :desc)
        goals = goals.where(date: range_start(params[:range])..Date.current) if params[:range].present?
        render json: goals
      end

      private

      def range_start(range)
        case range
        when "weekly" then Date.current.beginning_of_week
        when "monthly" then Date.current.beginning_of_month
        else Date.current
        end
      end
    end
  end
end
