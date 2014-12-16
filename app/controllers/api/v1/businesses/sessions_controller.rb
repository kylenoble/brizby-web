module V1
  class Api::V1::Businesses::SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_filter :verify_authenticity_token, if: :json_request?

    acts_as_token_authentication_handler_for Business, fallback_to_devise: false
    skip_before_filter :authenticate_entity_from_token!
    skip_before_filter :authenticate_entity!
    skip_before_filter :verify_signed_out_user


    def create
      warden.authenticate!(:scope => resource_name)
      @business = current_api_v1_business

      render json: {
        message:    'Logged in',
        auth_token: @business.authentication_token,
        email: @business.email
      }, status: :ok
    end

    def destroy
      if api_v1_business_signed_in?
        @business = current_api_v1_business
        @business.authentication_token = nil
        @business.save

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
              message: 'Failed to log out. Business must be logged in.'
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