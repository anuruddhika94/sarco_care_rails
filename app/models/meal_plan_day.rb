class MealPlanDay < ApplicationRecord
  has_many :meal_plan_meals, -> { order(:position) }, dependent: :destroy, inverse_of: :meal_plan_day

  validates :day_number, presence: true, uniqueness: true

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :day_number, :label_en, :label_th, :day_total_en, :day_total_th],
      include: { meal_plan_meals: {} }
    ))
  end
end
