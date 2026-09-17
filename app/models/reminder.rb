class Reminder < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :reminders

  enum :kind, {
    breakfast: 0, lunch: 1, dinner: 2, water: 3,
    exercise: 4, medication: 5, sleep: 6
  }

  validates :kind, uniqueness: { scope: :patient_id }

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(only: [:id, :kind, :time_of_day, :enabled]))
  end
end
