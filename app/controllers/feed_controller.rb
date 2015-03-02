class FeedController < ApplicationController
  before_filter :authenticate_user!

  def index
  	if user_signed_in?
  		@user = current_user
  		@follow_activities = Activity.where("owner_id = ?", @user.following).order("created_at desc")
  		@global_activities = Activity.all.order("created_at desc")
			@local_activities = Activity.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance])
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
end