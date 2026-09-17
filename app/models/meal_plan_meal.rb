class MealPlanMeal < ApplicationRecord
  belongs_to :meal_plan_day, inverse_of: :meal_plan_meals
  has_many :meal_plan_items, -> { order(:position) }, dependent: :destroy, inverse_of: :meal_plan_meal

  enum :slot, { breakfast: 0, lunch: 1, dinner: 2, before_bed: 3, snack: 4 }

  validates :title_en, :title_th, :icon, :total_protein_en, :total_protein_th, presence: true

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :slot, :title_en, :title_th, :icon, :total_protein_en, :total_protein_th, :image, :position],
      include: { meal_plan_items: {} }
    ))
  end
end
