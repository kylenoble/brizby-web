class FeedController < ApplicationController
  before_filter :authenticate_user!

  def index
  	if user_signed_in?
  		@user = current_user

      if feed_params[:type] == "global"
        @activities = Activity.where("category = ? OR category = 'global'", feed_params[:category]).(order("created_at desc")
      elsif feed_params[:type] == "local"
        @activities = Activity.near([feed_params[:lat], feed_params[:lon]], feed_params[:distance]).where("category = ? OR category = 'global'", feed_params[:category]).order("created_at desc") 
      else 
        @activities = Activity.where("owner_id = ? AND category = ? OR category = 'global'", @user.following, feed_params[:category]).order("created_at desc")
      end

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
  		params.permit(:lat, :lon, :distance, :category, :type)
  	end
end