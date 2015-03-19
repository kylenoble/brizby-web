class Api::V1::LovesController < Api::BaseController
	def index
		@users =  Love.where('loveable_id = ? AND loveable_type = ?', params[:loveable_id], params[:loveable_type]).pluck("user_id")
		@lovers = User.find(@users)
	end

	def create
		@love = Love.new(love_params)
		puts @love
		if @love.save 
			render :json => {:state => {:code => 0}, :data => "Successfully Loved" }
		else 
			render :json => {:state => {:code => 1, :messages => @love.errors.full_messages} }, status: 422
		end
	end 

	def destroy
		@love = Love.where("loveable_id = ? AND user_id = ?", love_params[:loveable_id].to_i, love_params[:user_id].to_i).first
		
		@love.destroy
		
		if @love.destroyed?
			render :json => {:state => {:code => 0}, :data => "Successfully UnLoved" }
		else 
			render :json => {:state => {:code => 1, :messages => @love.errors.full_messages} }, status: 422
		end
	end

	private

	def love_params
		params.require(:api_v1_love).permit(:user_id, :loveable_id, :loveable_type)
	end
end