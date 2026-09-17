class CreatePatientExercisePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :patient_exercise_plans do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :exercise, null: false, foreign_key: true
      t.integer :day_number, null: false
      t.integer :minutes, null: false
      t.boolean :in_my_plan, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :patient_exercise_plans, [:patient_id, :exercise_id], unique: true
  end
end
