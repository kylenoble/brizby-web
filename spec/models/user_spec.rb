require 'rails_helper'
require 'spec_helper'
require 'user'

RSpec.describe User, :type => :model do
	it 'create users' do
		user = User.new(email: "test@test.com", password: "supgirl", username: "test")
		assert user.email == "test@test.com"
		assert user.password == "supgirl"
		assert user.username == "test"
		assert user.authentication_token != ""
	end
end

