class CreateMealPlanMeals < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_plan_meals do |t|
      t.references :meal_plan_day, null: false, foreign_key: true
      t.integer :slot, null: false
      t.string :title_en, null: false
      t.string :title_th, null: false
      t.string :icon, null: false
      t.string :total_protein_en, null: false
      t.string :total_protein_th, null: false
      t.string :image
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
