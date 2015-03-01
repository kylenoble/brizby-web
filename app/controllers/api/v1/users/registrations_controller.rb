module V1
  class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    def create
      @user = User.create(user_params)
      @user.valid?
      if @user.save!
        sign_in(@user)
        render :json => {:state => {:code => 0}, :data => @user }
      else
        render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }, status: 422
      end

    end
    
    private

    def query_params
      params.permit(:email, :password, :name, :order)
    end

    def user_params
      params.require(:api_v1_user).permit(:email, :password, :name, :home_city, profile_pic_attributes: [:direct_upload_url])
    end
  end
end