class Businesses::SessionsController < Devise::SessionsController
  respond_to :html
  skip_before_filter :verify_authenticity_token, if: :json_request?

  skip_before_filter :authenticate_entity_from_token!
  skip_before_filter :authenticate_entity!
  skip_before_filter :verify_signed_out_user
  before_filter :authenticate_business!, :only => :destroy

  def create
    @business = warden.authenticate!(auth_options)
    sign_in(@business)
    respond_with @business, :location => after_sign_in_path_for(@business)
  end

  def destroy
    if business_signed_in?
      @business = current_business
      @business.authentication_token = nil
      @business.save

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
