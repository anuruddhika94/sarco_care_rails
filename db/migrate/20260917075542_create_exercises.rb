class CreateExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :exercises do |t|
      t.string :key, null: false
      t.string :name_en, null: false
      t.string :name_th, null: false
      t.string :video_id, null: false
      t.string :icon, null: false
      t.integer :default_minutes, null: false
      t.jsonb :instructions, null: false, default: []

      t.timestamps
    end

    add_index :exercises, :key, unique: true
  end
end
