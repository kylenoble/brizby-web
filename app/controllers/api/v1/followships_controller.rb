class Api::V1::FollowshipsController < Api::BaseController
	before_action :set_current_user 
	before_action :set_current_business

	def index
		if @business.nil?
			if params[:type] == "followers"
				@users = @user.followers.page(params[:page])
                                .per(params[:page_size])
			elsif params[:type] == "following"
				@users = @user.following
			else
				@users = []
			end
		elsif @user.nil?
			if params[:type] == "followers"
				@users = @business.followers.page(params[:page])
                                .per(params[:page_size])
			elsif params[:type] == "following"
				@users = @business.following.page(params[:page])
                                .per(params[:page_size])
			else
				@users = []
			end
		else
			@users = []
		end

		respond_with @users
	end

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
		if params[:user_type] == "user"
			@user = User.find(params["user_type_id"])
		end
	end

	def set_current_business
		if params[:user_type] == "business"
			@business = Business.find(params["user_type_id"])
		end
	end

	def followship_params
		params.require(:api_v1_followship).permit(:current_user_id, :current_business_id, :user_followed_id, :business_followed_id, :user_type, :user_type_id, :type, :page, :page_size)
	end
end