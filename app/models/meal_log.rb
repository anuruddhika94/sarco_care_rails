class MealLog < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :meal_logs
  belongs_to :meal_plan_meal

  validates :eaten_on, presence: true

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :eaten_on],
      include: { meal_plan_meal: {} }
    ))
  end
end
