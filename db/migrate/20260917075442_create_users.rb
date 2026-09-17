class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :phone_number, null: false
      t.string :email
      t.string :password_digest, null: false
      t.integer :role, null: false, default: 0
      t.date :date_of_birth
      t.integer :gender
      t.string :avatar_url
      t.jsonb :settings, null: false, default: {}

      t.timestamps
    end

    add_index :users, :phone_number, unique: true
  end
end
