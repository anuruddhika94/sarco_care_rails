class MealPlanItem < ApplicationRecord
  belongs_to :meal_plan_meal, inverse_of: :meal_plan_items

  validates :name_en, :name_th, :protein_en, :protein_th, presence: true

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(only: [:id, :name_en, :name_th, :protein_en, :protein_th, :position]))
  end
end
