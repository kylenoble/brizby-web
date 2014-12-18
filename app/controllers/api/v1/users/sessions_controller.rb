module V1
  class Api::V1::Users::SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_filter :verify_authenticity_token, if: :json_request?
    
    skip_before_filter :authenticate_entity_from_token!
    skip_before_filter :authenticate_entity!
    skip_before_filter :verify_signed_out_user
    before_filter :authenticate_user!, :only => :destroy

    def create
      warden.authenticate!(:scope => resource_name)
      @user = current_api_v1_user
      
      render json: {
        message:    'Logged in',
        auth_token: @user.authentication_token,
        email: @user.email
      }, status: :ok
    end

    def destroy
      if user_signed_in?
        @user = current_user
        @user.authentication_token = nil
        @user.save

        respond_to do |format|
          format.json {
            render json: {
              message: 'Logged out successfully.'
            }, status: :ok
          }
        end
      else
        respond_to do |format|
          format.json {
            render json: {
              message: 'Failed to log out. User must be logged in.'
            }, status: :ok
          }
        end
      end
    end

    private

    def json_request?
      request.format.json?
    end
  end
end