module V1
  class Api::V1::Businesses::SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_filter :verify_authenticity_token, if: :json_request?

    skip_before_filter :authenticate_entity_from_token!
    skip_before_filter :authenticate_entity!
    skip_before_filter :verify_signed_out_user
    before_filter :authenticate_business!, :only => :destroy

    def create
      @business = warden.authenticate!(auth_options)
      sign_in(@business)

      render json: {
        message:    'Logged in',
        auth_token: @business.authentication_token,
        email: @business.email,
        profile_pic: @business.profile_pic.image
      }, status: :ok
    end

    def destroy
      if api_v1_business_signed_in?
        @business = current_api_v1_business
        @business.authentication_token = nil
        @business.save
        sign_out(@business)

        respond_to do |format|
          format.json {
            render json: {
              message: 'Logged out successfully.'
            }, status: :ok
          }
        end
      else
        logger.info "business #{current_business}"
        puts business_signed_in?
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