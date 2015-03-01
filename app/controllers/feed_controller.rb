class FeedController < ApplicationController
  before_filter :authenticate_user!

  def index
  	if user_signed_in?
  		@user = current_user
  		@activities = Activity.where("owner_id = ?", @user.following).order("created_at desc")
  	else
  		redirect_to root_path
  	end
  end
end