class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?
  
  skip_before_filter :authenticate_entity_from_token!
  skip_before_filter :authenticate_entity!
  skip_before_filter :verify_signed_out_user
  before_filter :authenticate_user!, :only => :destroy

  def create
    warden.authenticate!(:scope => resource_name)
    @user = current_api_v1_user
    
    respond_with(@user)
  end

  def destroy
    if user_signed_in?
      @user = current_user
      @user.authentication_token = nil
      @user.save

      render 'businesses/sign_in'
      
    else
      render 'Error. Unable to logout. Please make sure you are logged in.'
    end
  end

  private

  def json_request?
    request.format.json?
  end
end