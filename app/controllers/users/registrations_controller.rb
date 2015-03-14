class Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.create(user_params)
    @user.valid?
    if @user.save!
      sign_in(@user)
      respond_with(@user)
    else
      respond_with(@user.errors.full_messages)
    end

  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :username, avatar_attributes: [:direct_upload_url])
  end
end
