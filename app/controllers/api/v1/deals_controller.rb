class Api::V1::DealsController < Api::V1::BaseController
  #before_filter :authenticate_user!
  
  private

  def authenticate_user!
    return if business_signed_in?
    super
  end

  def deal_params
     params.require(:api_v1_deal).permit(:name, :price, :expires_at, :description, :business_id)
   end

  def query_params
    params.permit(:name, :price, :expires_at, :description, :business_id)
  end

end