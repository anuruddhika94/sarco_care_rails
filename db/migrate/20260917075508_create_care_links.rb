class CreateCareLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :care_links do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.references :caretaker, null: false, foreign_key: { to_table: :users }
      t.string :relationship
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :care_links, [:patient_id, :caretaker_id], unique: true
  end
end
