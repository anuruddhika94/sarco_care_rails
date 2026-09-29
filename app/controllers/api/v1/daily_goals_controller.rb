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

      # Upserts the goals for one day (today unless a date is given). Used by
      # the checkboxes on the app's home screen.
      def update
        patient = acting_patient
        return unless patient

        date = params[:date].presence || Date.current
        goals = patient.daily_goal_completions.find_or_initialize_by(date: date)
        goals.assign_attributes(goal_params)
        if goals.save
          render json: goals
        else
          render json: { error: goals.errors.full_messages.to_sentence, errors: goals.errors }, status: :unprocessable_entity
        end
      end

      private

      def goal_params
        params.permit(:protein_done, :exercise_done, :water_done)
      end

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
