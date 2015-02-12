class Api::V1::FollowshipsController < Api::BaseController
	before_action :set_current_user

	def create
		if params["api_v1_followship"][:business_followed_id]
			@followship = @user.active_followships.create!(:business_followed_id => params["api_v1_followship"][:business_followed_id])
		else
			@followship = @user.active_followships.create!(:user_followed_id => params["api_v1_followship"][:user_followed_id])
		end	
		render :json => {:state => {:code => 0}, :data => @followship }
	end 

	def destroy

		if params["api_v1_followship"][:business_followed_id]
			@followship = @user.active_followships.business_followed_id.find(params["api_v1_followship"][:business_followed_id])
		else
			@followship = @user.active_followships.user_followed_id.find(params["api_v1_followship"][:user_followed_id])
		end

		@followship.destroy
		render :json => {:state => {:code => 0}, :data => "unfollowed" }
	end

	private

	def set_current_user
		@user = User.find(params["api_v1_followship"][:current_user_id])
	end

	def followship_params
		params.require(:api_v1_followship).permit(:current_user_id, :user_followed_id, :business_followed_id)
	end
end