FactoryBot.define do
  factory :user do
    spotify_id { "MyString" }
    name { "MyString" }
    expires_at { Time.now.utc}
  end
end
