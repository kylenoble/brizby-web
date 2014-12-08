require 'rails_helper'
require 'spec_helper'
require 'user'

RSpec.describe User, :type => :model do
	it 'create users' do
		user = User.new(email: "test@test.com", password: "supgirl")
		assert user.email == "test@test.com"
		assert user.password == "supgirl"
		assert user.authentication_token != ""
	end

	it 'creates users api' do
		post '/v1/users/sign_up',
		{ user:
			{ email: 'Bananas@mail.com', password: '1234512345' }
			}.to_json,
			{ 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
			assert_equal 201, response.status
			assert_equal Mime::JSON, response.content_type
	end
end

