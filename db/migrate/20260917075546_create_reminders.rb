class CreateReminders < ActiveRecord::Migration[8.1]
  def change
    create_table :reminders do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.integer :kind, null: false
      t.time :time_of_day
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end

    add_index :reminders, [:patient_id, :kind], unique: true
  end
end
