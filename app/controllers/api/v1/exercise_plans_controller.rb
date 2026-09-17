module Api
  module V1
    class ExercisePlansController < ApplicationController
      include PatientScoped

      def index
        patient = acting_patient
        return unless patient

        plans = patient.patient_exercise_plans.includes(:exercise).order(:position)
        plans = plans.where(in_my_plan: true) if params[:my_plan] == "true"
        render json: plans
      end

      def create
        patient = acting_patient
        return unless patient

        plan = patient.patient_exercise_plans.new(exercise_plan_params)
        if plan.save
          render json: plan, status: :created
        else
          render json: { error: "Validation failed", errors: plan.errors }, status: :unprocessable_entity
        end
      end

      # Toggle whether an exercise is in the patient's "My Plan".
      def update
        patient = acting_patient
        return unless patient

        plan = patient.patient_exercise_plans.find(params[:id])
        plan.update!(in_my_plan: params[:in_my_plan])
        render json: plan
      end

      private

      def exercise_plan_params
        params.permit(:exercise_id, :day_number, :minutes, :in_my_plan, :position)
      end
    end
  end
end
