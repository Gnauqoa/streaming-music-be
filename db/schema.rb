# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_30_023048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "platform_id"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "artist_external_id"
    t.json "images"
    t.json "genres"
    t.integer "followers_count", default: 0
    t.date "birth"
    t.integer "status", default: 0
  end

  create_table "blocked_ip_addresses", force: :cascade do |t|
    t.string "ip_address", null: false
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "music_artists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id", null: false
    t.bigint "music_id", null: false
    t.index ["artist_id"], name: "index_music_artists_on_artist_id"
    t.index ["music_id"], name: "index_music_artists_on_music_id"
  end

  create_table "musics", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "source_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
    t.string "music_external_id"
    t.datetime "release_date"
    t.string "release_date_precision"
    t.json "images"
    t.bigint "duration_ms"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name", null: false
    t.string "client_id", null: false
    t.text "public_key", null: false
    t.text "private_key", null: false
    t.boolean "admin", default: false, null: false
    t.string "hosts", default: [], null: false, array: true
    t.string "scope", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_platforms_on_client_id", unique: true
  end

  create_table "playlist_musics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "music_id"
    t.bigint "playlist_id"
    t.index ["music_id"], name: "index_playlist_musics_on_music_id"
    t.index ["playlist_id"], name: "index_playlist_musics_on_playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "likes_count", default: 0
    t.string "playlist_external_id"
    t.jsonb "images"
    t.integer "total_tracks"
    t.integer "status", default: 1
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "post_music_requests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "status", default: 1
    t.bigint "artist_id"
    t.string "music_external_id"
    t.string "source_url"
    t.string "release_date_precision"
    t.datetime "release_date"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_logs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "timestamp"
    t.string "ip_address"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_liked_musics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "music_id", null: false
    t.index ["music_id"], name: "index_user_liked_musics_on_music_id"
    t.index ["user_id"], name: "index_user_liked_musics_on_user_id"
  end

  create_table "user_liked_playlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "playlist_id", null: false
    t.index ["playlist_id"], name: "index_user_liked_playlists_on_playlist_id"
    t.index ["user_id"], name: "index_user_liked_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "avatar_url"
    t.date "birth"
  end

  add_foreign_key "music_artists", "artists"
  add_foreign_key "music_artists", "musics"
  add_foreign_key "playlist_musics", "musics"
  add_foreign_key "playlist_musics", "playlists"
  add_foreign_key "playlists", "users"
  add_foreign_key "user_liked_musics", "musics"
  add_foreign_key "user_liked_musics", "users"
  add_foreign_key "user_liked_playlists", "playlists"
  add_foreign_key "user_liked_playlists", "users"
end
