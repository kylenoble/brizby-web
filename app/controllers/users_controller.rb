class UsersController < ApplicationController
  respond_to :html
  #before_filter :authenticate_user!

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  private
    def authenticate_user!
      return if business_signed_in?
      super
    end

	def user_params
  	  params.require(:user).permit(:id, :name)
	end
end
