FactoryGirl.define do
  factory :business do
    email { Faker::Internet.email }
    password "12345678"
    profile_pic { Faker::Avatar.image("my-own-slug") }
  end
  factory :business_signin do
  	email { Faker::Internet.email }
  	password "12345678"
  end
end
