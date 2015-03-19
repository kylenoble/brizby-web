class Api::V1::UsersController < Api::V1::BaseController
	#before_filter :authenticate_user!

	def index
		if params[:type] == "followers"
			@users = current_api_v1_user.followers
		elsif params[:type] == "followees"
			@users = current_api_v1_user.followees
		else
			@users = []
		end

		respond_with @users
	end

	private

	def authenticate_user!
    return if business_signed_in?
    super
  end

	def user_params
  	params.require(:api_v1_user).permit(:id, :email, :home_city, :user_type, :type)
	end
end
