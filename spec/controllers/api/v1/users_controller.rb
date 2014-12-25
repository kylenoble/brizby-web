require 'spec_helper'
require 'rails_helper'

describe Api::V1::Users::UsersController do
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "POST Sign In" do
    it "on success, returns the user's authentication token" do
      user = FactoryGirl.create(:user)

      user_params = {
        "api_v1_user" => {
          "username" => user.username,
          "password" => user.password
        }
      }.to_json
      
      post "/api/v1/users/sign_in.json", user_params

      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      puts response.body
      expect(json['authentication_token']).to eq(user.authentication_token)
    end
  end
end