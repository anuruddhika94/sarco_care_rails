class CreateAssessments < ActiveRecord::Migration[8.1]
  def change
    create_table :assessments do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.jsonb :answers, null: false, default: []
      t.integer :score, null: false
      t.datetime :completed_at, null: false

      t.timestamps
    end

    add_index :assessments, [:patient_id, :completed_at]
  end
end
