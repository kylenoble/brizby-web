class FeedController < ApplicationController
  before_filter :authenticate_user!

  def index
  	if user_signed_in?
  		@user = current_user
  	else
  		redirect_to root_path
  	end
  end
end