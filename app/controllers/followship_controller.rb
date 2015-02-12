class FollowshipController < ApplicationController
	def create
		if !params[:user_followed_id]
			@followship = current_user.followships.create!(:business_followed_id => params[:business_followed_id])
		else
			@followship = current_user.followships.create!(:user_followed_id => params[:user_followed_id])
		end	
	end 

	def destroy

		if !params[:user_followed_id]
			@followship = current_user.followships.business_followed_id.find(params[:business_followed_id])
		else
			@followship = current_user.followships.user_followed_id.find(params[:user_followed_id])
		end

		@followship.destroy
	end

	private

	def followship_params
		params.permit(:user_id, :user_followed_id, :business_followed_id)
	end
end