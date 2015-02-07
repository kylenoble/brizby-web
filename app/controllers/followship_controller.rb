class FollowshipController < ApplicationController
	def create
		if !followship_params[:user_follow_id]
			@followship = current_user.followships.create!(:business_follow_id => followship_params[:business_follow_id])
		else
			@followship = current_user.followships.create!(:user_follow_id => followship_params[:user_follow_id])
		end	
	end 

	def destroy

		if !followship_params[:user_follow_id]
			@followship = current_user.followships.business_follow_id.find(params[:business_follow_id])
		else
			@followship = current_user.followships.user_follow_id.find(params[:user_follow_id])
		end

		@followship.destroy
	end

	private

	def followship_params
		params.permit(:user_id, :user_follow_id, :business_follow_id)
end