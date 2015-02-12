FactoryGirl.define do
  factory :business do
    email { Faker::Internet.email }
    password "12345678"
    direct_upload_url { Faker::Avatar.image("my-own-slug") }
  end
  factory :business_signin do
  	email { Faker::Internet.email }
  	password "12345678"
  end
end
