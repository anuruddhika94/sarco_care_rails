class CreateMealPlanDays < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_plan_days do |t|
      t.integer :day_number, null: false
      t.string :label_en, null: false
      t.string :label_th, null: false
      t.string :day_total_en, null: false
      t.string :day_total_th, null: false

      t.timestamps
    end

    add_index :meal_plan_days, :day_number, unique: true
  end
end
