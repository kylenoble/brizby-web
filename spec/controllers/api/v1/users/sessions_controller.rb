require 'spec_helper'
require 'rails_helper'
require 'devise/test_helpers'

describe Api::V1::Users::SessionsController do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    describe "POST #create" do

    context "when is successfully created" do

      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { :api_v1_user => {
                          username: @user_attributes["username"],
                          password: @user_attributes["password"]
                        }  
                      }, format: :json
        puts @user_attributes
      end

      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        puts user_response
        expect(user_response[:data][:email]).to eql @user_attributes[:email]
        expect(user_response[:state][:code]).to eq 0
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the username
        @invalid_user_attributes = { password: "12345678",
                                    }
        post :create, { api_v1_user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:state][:code]).to eq 1 
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:state][:messages]).to eq ["Username can't be blank"]
      end

      it { should respond_with 422 }
    end
  end
end