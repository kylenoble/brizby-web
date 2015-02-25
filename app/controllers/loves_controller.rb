class LoveController < ApplicationController
	def create
		@love = Love.new(love_params)
		if @love.save 
			render :json => {:state => {:code => 0}, :data => "Successfully Loved" }
		else 
			render :json => {:state => {:code => 1, :messages => @love.errors.full_messages} }, status: 422
		end
	end 

	def destroy
		@love = Love.where("loveable_id = ? && user_id = ?", params[:loveable_id], params[:user_id])

		if @love.destroy
			render :json => {:state => {:code => 0}, :data => "Successfully UnLoved" }
		else 
			render :json => {:state => {:code => 1, :messages => @love.errors.full_messages} }, status: 422
		end
	end

	private

	def love_params
		params.permit(:user_id, :loveable_id, :loveable_type)
	end
end