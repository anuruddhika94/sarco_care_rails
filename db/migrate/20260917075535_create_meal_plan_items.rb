class CreateMealPlanItems < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_plan_items do |t|
      t.references :meal_plan_meal, null: false, foreign_key: true
      t.string :name_en, null: false
      t.string :name_th, null: false
      t.string :protein_en, null: false
      t.string :protein_th, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
