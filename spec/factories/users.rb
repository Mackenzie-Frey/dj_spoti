FactoryBot.define do
  factory :user do
    spotify_id { |n| "#{n}lkajfd;lfkj" }
    name { "MyString" }
    expires_at { Time.now.utc}
  end
end
