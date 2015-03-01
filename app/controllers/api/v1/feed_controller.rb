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

  	def local_businesses
  		businesses = []
  		Business.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance]).map {|business| businesses.push(business.id)}
  		return businesses
  	end

  	def local_users
  		users = []
  		#User.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance]).map {|user| users.push(user.id)}
  		return users
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
  		activities = Arel::Table.new(:activities)
			biz = activities[:owner_id].in(local_businesses).and(activities[:owner_type].eq('Business'))
			user  = activities[:owner_id].in(local_users).and(activities[:owner_type].eq('User'))
			return Activity.where(biz.or(user))
						.order("created_at desc")
						.page(feed_params[:page])
            .per(feed_params[:page_size])
		end
end