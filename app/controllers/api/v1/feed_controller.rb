class Api::V1::FeedController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
  	if api_v1_user_signed_in?
  		@user = current_api_v1_user
  		@follow_activities = Activity.where("owner_id = ?", @user.following).order("created_at desc")
  		@global_activities = Activity.all.order("created_at desc")
			@local_activities = local_activities_query
  	else
  		render :json => {:state => {:code => 1, :messages => "user not signed in"} }, status: 401
  	end
  end

  private

    def authenticate_user!
	    return if business_signed_in?
	    super
	  end

  	def feed_params
  		params.permit(:lat, :lon, :distance)
  	end

  	def local_businesses
  		businesses = []
  		Business.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance]).map {|business| businesses.push(business.id)}
  		return businesses
  	end

  	def local_users
  		users = []
  		User.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance]).map {|user| users.push(user.id)}
  		return users
  	end

  	def local_activities_query
  		activities = Arel::Table.new(:activities)
			biz = activities[:owner_id].in(local_businesses).and(activities[:owner_type].eq('Business'))
			user  = activities[:owner_id].in(local_users).and(activities[:owner_type].eq('User'))
			return Activity.where(biz.or(user)).order("created_at desc")
		end
end