module Api
  module V1
    class CareLinksController < ApplicationController
      # Patients see care links where they're the patient; caretakers see
      # theirs. `?status=pending` narrows to just pending requests (used for
      # the patient-side approval banner).
      def index
        links = current_user.patient? ? current_user.patient_care_links : current_user.caretaker_care_links
        links = links.where(status: params[:status]) if params[:status].present?
        render json: links.includes(:patient, :caretaker).order(created_at: :desc)
      end

      # Caretaker-only: look up a patient by phone number without sending a
      # request yet, so AddPatientScreen can show who they'd be linking to
      # before confirming.
      def lookup
        unless current_user.caretaker?
          return render json: { error: "Only caretakers can look up patients" }, status: :forbidden
        end

        patient = User.patient.find_by(phone_number: params[:phone_number])
        return render json: { error: "No patient found with that phone number" }, status: :not_found unless patient

        render json: patient
      end

      # Caretaker-only: search for a patient by phone number and send a link
      # request (mirrors AddPatientScreen).
      def create
        unless current_user.caretaker?
          return render json: { error: "Only caretakers can send care link requests" }, status: :forbidden
        end

        patient = User.patient.find_by(phone_number: params[:phone_number])
        return render json: { error: "No patient found with that phone number" }, status: :not_found unless patient

        link = CareLink.new(
          patient: patient,
          caretaker: current_user,
          relationship: params[:relationship],
          status: :pending
        )
        if link.save
          render json: link, status: :created
        else
          render json: { error: link.errors.full_messages.to_sentence, errors: link.errors }, status: :unprocessable_entity
        end
      end

      # Patient-only: approve or decline a pending request sent to them
      # (mirrors CaretakerApprovalScreen).
      def update
        link = current_user.patient_care_links.find(params[:id])
        status = params[:status]
        unless %w[approved declined].include?(status)
          return render json: { error: "status must be 'approved' or 'declined'" }, status: :unprocessable_entity
        end

        link.update!(status: status)
        render json: link
      end
    end
  end
end
