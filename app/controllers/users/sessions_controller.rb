class Users::SessionsController < Devise::SessionsController
  respond_to :html
  skip_before_filter :verify_authenticity_token, if: :json_request?
  
  skip_before_filter :authenticate_entity_from_token!
  skip_before_filter :authenticate_entity!
  skip_before_filter :verify_signed_out_user

  def create
    if user_signed_in?
      @user = warden.authenticate!(auth_options)
      sign_in(@user)
      respond_with @user, :location => after_sign_in_path_for(@user)
    end
  end

  def destroy
    if user_signed_in?
      sign_out
      render :status => 200,
             :json => { :error => false,
                        :message => "Logged out"
             }
    else
      render :status => 200,
             :json => { :error => true,
                        :message => 'Unable to logout. Please make sure you are logged in.'
             }
    end
  end

  private

  def json_request?
    request.format.json?
  end
end