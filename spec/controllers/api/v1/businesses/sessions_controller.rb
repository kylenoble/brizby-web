require 'spec_helper'
require 'rails_helper'
require 'devise/test_helpers'

describe Api::V1::Businesses::SessionsController do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:business]
    end

    describe "POST #create" do

    context "when is successfully created" do

      before(:each) do
        @business_attributes = FactoryGirl.attributes_for :business
        post :create, { api_v1_business: @business_attributes }, format: :json
      end

      it "renders the json representation for the business record just created" do
        business_response = JSON.parse(response.body, symbolize_names: true)
        puts business_response
        expect(business_response[:data][:email]).to eql @business_attributes[:email]
        expect(business_response[:state][:code]).to eq 0
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the businessname
        @invalid_business_attributes = { password: "12345678",
                                    }
        post :create, { api_v1_business: @invalid_business_attributes }, format: :json
      end

      it "renders an errors json" do
        business_response = JSON.parse(response.body, symbolize_names: true)
        expect(business_response[:state][:code]).to eq 1 
      end

      it "renders the json errors on whye the business could not be created" do
        business_response = JSON.parse(response.body, symbolize_names: true)
        expect(business_response[:state][:messages]).to eq ["businessname can't be blank"]
      end

      it { should respond_with 422 }
    end
  end
end