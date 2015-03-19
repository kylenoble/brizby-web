class Api::V1::FollowshipsController < Api::BaseController
	before_action :set_current_user

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
			respond_with @users
		elsif @user.nil?
			if params[:type] == "followers"
				@businesses = @business.followers.page(params[:page])
                                .per(params[:page_size])
			elsif params[:type] == "following"
				@businesses = @business.following.page(params[:page])
                                .per(params[:page_size])
			else
				@businesses = []
				respond_with @businesses
			end
		else
			@results = []
			respond_with @results
		end
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
		@user = User.find(params[:current_user_id])
	end

	def set_current_business
		@business = Business.find(params["api_v1_followship"][:current_business_id])
	end

	def followship_params
		params.require(:api_v1_followship).permit(:current_user_id, :current_business_id, :user_followed_id, :business_followed_id, :type, :page, :page_size)
	end
end