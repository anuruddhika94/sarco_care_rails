class ExerciseLog < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :exercise_logs
  belongs_to :exercise

  validates :completed_on, :minutes, presence: true

  scope :in_range, lambda { |range|
    case range
    when "week" then where(completed_on: Date.current.beginning_of_week..Date.current.end_of_week)
    when "month" then where(completed_on: Date.current.beginning_of_month..Date.current.end_of_month)
    else where(completed_on: Date.current)
    end
  }

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :completed_on, :minutes],
      include: { exercise: {} }
    ))
  end
end
