class CreateExerciseLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :exercise_logs do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :exercise, null: false, foreign_key: true
      t.date :completed_on, null: false
      t.integer :minutes, null: false

      t.timestamps
    end

    add_index :exercise_logs, [:patient_id, :completed_on]
  end
end
