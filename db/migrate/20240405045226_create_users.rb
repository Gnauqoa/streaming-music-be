class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string "email"
      t.string "username"
      t.string "first_name"
      t.string "last_name"
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at", precision: nil
      t.datetime "remember_created_at", precision: nil
      t.integer "platform_id"

      t.timestamps
    end
    create_table "platforms", force: :cascade do |t|
      t.string "name", null: false
      t.string "client_id", null: false
      t.text "public_key", null: false
      t.text "private_key", null: false
      t.boolean "admin", default: false, null: false
      t.string "hosts", default: [], null: false, array: true
      t.string "scope", default: [], null: false, array: true
      t.index ["client_id"], name: "index_platforms_on_client_id", unique: true
      t.timestamps
    end
  end
end
