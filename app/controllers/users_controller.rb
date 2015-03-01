class UsersController < ApplicationController
  respond_to :json
  #before_filter :authenticate_user!

  def index
    @users = User.all
    render json: @users
  end

  def show
	@activities = Activity.where("owner_id = ?", @user.id).order("created_at desc")
	@user = User.find(params[:id])
	render json: @user.profile_pic.image 
  end

  private
    def authenticate_user!
      return if business_signed_in?
      super
    end

	def user_params
  	  params.require(:api_v1_user).permit(:id, :username)
	end
end
