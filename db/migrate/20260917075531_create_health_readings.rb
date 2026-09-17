class CreateHealthReadings < ActiveRecord::Migration[8.1]
  def change
    create_table :health_readings do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.date :recorded_on, null: false
      t.decimal :weight_kg, precision: 5, scale: 2
      t.decimal :height_cm, precision: 5, scale: 2
      t.decimal :calf_cm, precision: 5, scale: 2

      t.timestamps
    end

    add_index :health_readings, [:patient_id, :recorded_on]
  end
end
