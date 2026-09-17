class CreateMealLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_logs do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :meal_plan_meal, null: false, foreign_key: true
      t.date :eaten_on, null: false

      t.timestamps
    end

    add_index :meal_logs, [:patient_id, :eaten_on]
  end
end
