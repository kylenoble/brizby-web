class Api::V1::FollowshipsController < Api::BaseController
	before_action :set_current_user

	def create
		if params["api_v1_followship"][:business_followed_id]
			@followship = @user.active_followships.create!(:business_followed_id => params["api_v1_followship"][:business_followed_id])
		else
			@followship = @user.active_followships.create!(:user_followed_id => params["api_v1_followship"][:user_followed_id])
		end	
		if @followship.save 
			render :json => {:state => {:code => 0}, :data => "Successfully Followed" }
		else 
			render :json => {:state => {:code => 1, :messages => @followship.errors.full_messages} }, status: 422
		end
	end 

	def destroy

		if params["api_v1_followship"][:business_followed_id]
			@followship = Followship.where(:user_id => @user, :business_followed_id => params["api_v1_followship"][:business_followed_id]).first
		else
			@followship = Followship.where(:user_id => @user, :user_followed_id => params["api_v1_followship"][:business_followed_id]).first
		end

		@followship.destroy
		
		if @followship.destroyed?
			render :json => {:state => {:code => 0}, :data => "unfollowed" }
		else 
			render :json => {:state => {:code => 1, :messages => @followship.errors.full_messages} }, status: 422
		end

	end

	private

	def set_current_user
		@user = User.find(params["api_v1_followship"][:current_user_id])
	end

	def followship_params
		params.require(:api_v1_followship).permit(:current_user_id, :user_followed_id, :business_followed_id)
	end
end