ActiveRecord::Schema.define(version: 2019_04_03_042608) do
  enable_extension "plpgsql"
  create_table "users", force: :cascade do |t|
    t.string "spotify_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "refresh_token"
  end
end
