module V1
  class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    def create
      @user = User.create(user_params)
      puts "valid"
      @user.valid?
      if @user.save!
        puts "saving"
        sign_in(@user)
        render :json => {:state => {:code => 0}, :data => @user }
      else
        puts "no save"
        render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }, status: 422
      end

    end
    
    private

    def user_params
      params.require(:api_v1_user).permit(:email, :password, :username, profile_pic_attributes: [:direct_upload_url])
    end
  end
end