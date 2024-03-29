class LovesController < ApplicationController
	def create
		@love = Love.new(love_params)
		if @love.save 
			respond_with("Loved")
		else 
			respond_with(@love.errors.full_messages)
		end
	end 

	def destroy
		@love = Love.where("loveable_id = ? && user_id = ?", params[:loveable_id], params[:user_id])
		
		@love.destroy

		if @love.destroyed?
			respond_with("UnLoved")
		else 
			respond_with(@love.errors.full_messages)
		end
	end

	private

	def love_params
		params.require(:love).permit(:current_user_id, :loveable_id, :loveable_type)
	end
end