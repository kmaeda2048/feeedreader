FactoryBot.define do
  factory :user do
    email { 'example@example.com' }
    password { 'password' }

    trait :foo do
      email { 'foo@example.com' }
    end
  end
end
