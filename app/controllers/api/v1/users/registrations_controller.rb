module V1
  class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    def create
      @user = User.create(user_params)
      if @user.save
        render :json => {:state => {:code => 0}, :data => @user }
      else
        render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
      end

    end
    
    private

    def user_params
      params.require(:api_v1_user).permit(:email, :password, :username)
    end
  end
end