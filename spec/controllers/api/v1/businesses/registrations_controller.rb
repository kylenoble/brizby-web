require 'spec_helper'
require 'rails_helper'

describe Api::V1::Businesses::RegistrationsController do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:business]
    end

    describe "POST #create" do

    context "when is successfully created" do

      before(:each) do
        @business_attributes = FactoryGirl.attributes_for :business
        @profile_pic = FactoryGirl.attributes_for :profile_pic
        puts @profile_pic
        post :create, { :api_v1_business => {
                          email: @business_attributes[:email], 
                          password: @business_attributes[:password],
                          :profile_pic_attributes => {
                            image: @profile_pic[:image]
                          } 
                        } 
                      }, format: :json
        puts @business_attributes
      end

      it "renders the json representation for the business record just created" do
        business_response = JSON.parse(response.body, symbolize_names: true)
        expect(business_response[:data][:email]).to eql @business_attributes[:email]
        expect(business_response[:state][:code]).to eq 0
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_business_attributes = { password: "12345678" }
        post :create, { api_v1_business: @invalid_business_attributes }, format: :json
      end

      it "renders an errors json" do
        business_response = JSON.parse(response.body, symbolize_names: true)
        expect(business_response[:state][:code]).to eq 1 
      end

      it "renders the json errors on whye the business could not be created" do
        business_response = JSON.parse(response.body, symbolize_names: true)
        expect(business_response[:state][:messages]).to eq ["Email can't be blank"]
      end

      it { should respond_with 422 }
    end
  end
end