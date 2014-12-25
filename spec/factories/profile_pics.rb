FactoryGirl.define do
  factory :profile_pic do
    image { Faker::Avatar.image }
  end
end
