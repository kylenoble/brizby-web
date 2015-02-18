class Api::V1::DealsController < Api::V1::BaseController
  #before_filter :authenticate_user!
  
  private

  def authenticate_user!
    return if business_signed_in?
    super
  end

  def deal_params
     params.require(:deal).permit(:name, :price, :expires_at, :description, :business_id, images_attributes: [:direct_upload_url])
   end

  def query_params
    params.permit(:name, :price, :expires_at, :description, :business_id, :id)
  end

end