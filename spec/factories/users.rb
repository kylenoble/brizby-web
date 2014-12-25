FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "12345678"
  end
   factory :user_sign_in do
    username { Faker::Internet.user_name }
    password "12345678"
  end
end