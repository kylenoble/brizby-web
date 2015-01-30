class Api::V1::UsersController < Api::V1::BaseController
	#before_filter :authenticate_user!


	private

	def authenticate_user!
    return if business_signed_in?
    super
  end

	def user_params
  	params.require(:api_v1_user).permit(:id, :username, :email, :home_city)
	end

	 def query_params
  	params.permit(:id, :username, :email, :home_city)
  end
end
