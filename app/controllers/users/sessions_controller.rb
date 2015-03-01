class Users::SessionsController < Devise::SessionsController
  respond_to :html
  skip_before_filter :verify_authenticity_token, if: :json_request?
  
  skip_before_filter :authenticate_entity_from_token!
  skip_before_filter :authenticate_entity!
  skip_before_filter :verify_signed_out_user

  def create
    @user = warden.authenticate!(auth_options)
    sign_in(@user)
    respond_with @user, :location => after_sign_in_path_for(@user)
  end

  def destroy
    if user_signed_in?
      sign_out_and_redirect(current_user)
    else
      render 'Error. Unable to logout. Please make sure you are logged in.'
    end
  end

  private

  def json_request?
    request.format.json?
  end
end