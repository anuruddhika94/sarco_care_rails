class ExerciseLog < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :exercise_logs
  belongs_to :exercise

  validates :completed_on, :minutes, presence: true

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :completed_on, :minutes],
      include: { exercise: {} }
    ))
  end
end
