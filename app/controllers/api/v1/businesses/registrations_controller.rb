module V1
  class Api::V1::Businesses::RegistrationsController < Devise::RegistrationsController
    def create
      @business = Business.create(business_params)
      if @business.save
        sign_in(@business)
        render :json => {:state => {:code => 0}, :data => @business }
      else
        render :json => {:state => {:code => 1, :messages => @business.errors.full_messages} }, status: 422
      end
    end
    
    private

    def business_params
      params.require(:api_v1_business).permit(:email, :password, :category, profile_pic_attributes: [:image])
    end
  end
end