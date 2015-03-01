class Businesses::SessionsController < Devise::SessionsController
  respond_to :html
  skip_before_filter :verify_authenticity_token, if: :json_request?

  skip_before_filter :authenticate_entity_from_token!
  skip_before_filter :authenticate_entity!
  skip_before_filter :verify_signed_out_user
  before_filter :authenticate_business!, :only => :destroy

  def create
    warden.authenticate!(:scope => resource_name)
    @business = current_business

    render @business
  end

  def destroy
    if business_signed_in?
      @business = current_business
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
