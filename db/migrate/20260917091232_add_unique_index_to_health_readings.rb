class AddUniqueIndexToHealthReadings < ActiveRecord::Migration[8.1]
  def change
    remove_index :health_readings, [:patient_id, :recorded_on]
    add_index :health_readings, [:patient_id, :recorded_on], unique: true
  end
end
