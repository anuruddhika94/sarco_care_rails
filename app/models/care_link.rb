class CareLink < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :patient_care_links
  belongs_to :caretaker, class_name: "User", inverse_of: :caretaker_care_links

  enum :status, { pending: 0, approved: 1, declined: 2 }

  validates :patient_id, uniqueness: { scope: :caretaker_id }
  validate :patient_and_caretaker_have_correct_roles

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :relationship, :status, :created_at],
      include: { patient: {}, caretaker: {} }
    ))
  end

  private

  def patient_and_caretaker_have_correct_roles
    errors.add(:patient, "must have the patient role") if patient && !patient.patient?
    errors.add(:caretaker, "must have the caretaker role") if caretaker && !caretaker.caretaker?
  end
end
