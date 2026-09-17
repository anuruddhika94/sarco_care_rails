class PatientExercisePlan < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :patient_exercise_plans
  belongs_to :exercise

  validates :day_number, :minutes, presence: true
  validates :exercise_id, uniqueness: { scope: :patient_id }

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :day_number, :minutes, :in_my_plan, :position],
      include: { exercise: {} }
    ))
  end
end
