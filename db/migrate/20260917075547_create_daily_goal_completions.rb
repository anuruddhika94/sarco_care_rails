class CreateDailyGoalCompletions < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_goal_completions do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.date :date, null: false
      t.boolean :protein_done, null: false, default: false
      t.boolean :exercise_done, null: false, default: false
      t.boolean :water_done, null: false, default: false

      t.timestamps
    end

    add_index :daily_goal_completions, [:patient_id, :date], unique: true
  end
end
