FactoryGirl.define do
  factory :profile_pic do
    pre_image = Base64.encode64(Faker::Avatar.image)
    image { "data:image/png;base64," + pre_image }
  end
end
