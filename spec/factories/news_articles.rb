FactoryBot.define do
  factory :news_article do
    title { Faker::Hacker.say_something_smart }
    description { Faker::Lorem.paragraph }
    view_count { rand(10..1000) }
    association(:user, factory: :user)
  end
end
