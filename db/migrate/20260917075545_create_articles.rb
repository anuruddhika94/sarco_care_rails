class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.integer :category, null: false
      t.string :icon, null: false
      t.string :title_en, null: false
      t.string :title_th, null: false
      t.string :summary_en, null: false
      t.string :summary_th, null: false
      t.text :body_en, array: true, null: false, default: []
      t.text :body_th, array: true, null: false, default: []
      t.integer :read_minutes, null: false, default: 3
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
