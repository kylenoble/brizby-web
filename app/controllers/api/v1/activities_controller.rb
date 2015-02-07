class Api::V1::ActivitiesController < Api::V1::BaseController
  #before_filter :authenticate_user!
  

  private

  def authenticate_user!
    return if business_signed_in?
    super
  end

  def query_params
    params.permit(:trackable_id, :owner_id, :recipient_id)
  end

end