class DailyGoalCompletion < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :daily_goal_completions

  validates :date, presence: true, uniqueness: { scope: :patient_id }

  GOAL_COUNT = 3

  def score
    ([protein_done, exercise_done, water_done].count(true) / GOAL_COUNT.to_f * 100).round
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :date, :protein_done, :exercise_done, :water_done],
      methods: [:score]
    ))
  end
end
