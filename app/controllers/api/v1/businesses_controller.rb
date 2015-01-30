class Api::V1::BusinessesController < Api::V1::BaseController
	#before_filter :authenticate_user!
	
	private

	def authenticate_user!
    return if business_signed_in?
    super
  end

	def business_params
  	params.require(:api_v1_business).permit(:id, :email, :full_address, :phone_number, :about, :latitude, :longitude)
	end

	def query_params
  	params.permit(:id, :email, :full_address, :phone_number, :about, :latitude, :longitude)
  end

end
