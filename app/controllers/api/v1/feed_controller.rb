class Api::V1::FeedController < Api::V1::BaseController
  #before_filter :authenticate_user!

  def index
  	if api_v1_user_signed_in?
  		@user = current_api_v1_user
			if feed_params[:type] == "global"
				@activities = global_activities_query
				render 'index'
			elsif feed_params[:type] == "local"
				@activities = local_activities_query
				render 'index'
			elsif feed_params[:type] == "following"
				@activities = following_activities_query(@user)
				render 'index'
			end
  	else
  		render :json => {:state => {:code => 1, :messages => "user not signed in"} }, status: 401
  	end
  end

  private

  	def json_request?
      request.format.json?
    end

    def authenticate_user!
	    return if business_signed_in?
	    super
	  end

  	def feed_params
  		params.permit(:lat, :lon, :distance, :page, :page_size, :type)
  	end

  	def following_activities_query(user)
  		return Activity.where("owner_id = ?", user.following)
						.order("created_at desc")
				    .page(feed_params[:page])
				    .per(feed_params[:page_size])
  	end

  	def global_activities_query
  		return Activity.all
						.order("created_at desc")
						.page(feed_params[:page])
            .per(feed_params[:page_size])
  	end

  	def local_activities_query
			return Activity.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance])
							.order("created_at desc")
							.page(feed_params[:page])
				      .per(feed_params[:page_size])
		end
end