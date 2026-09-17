# Resolves which patient a request's data belongs to. A patient always acts
# on their own records; a caretaker must pass `?patient_id=` and have an
# approved CareLink to that patient.
module PatientScoped
  extend ActiveSupport::Concern

  private

  def acting_patient
    if current_user.patient?
      current_user
    else
      patient = User.patient.find_by(id: params[:patient_id])
      render json: { error: "patient_id is required and must be an approved patient" }, status: :forbidden and return nil unless patient

      linked = current_user.patients.exists?(id: patient.id)
      render json: { error: "Not authorized for this patient" }, status: :forbidden and return nil unless linked

      patient
    end
  end
end
