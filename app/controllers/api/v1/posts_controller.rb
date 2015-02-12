class Api::V1::PostsController < Api::V1::BaseController

	private

    def set_post
      @post = Post.find(params[:id])
    end

    def query_params
	    params.permit(:body, :business_id, :user_id)
	  end

    def post_params
      params.require(:post).permit(:body, :business_id, :user_id, image_attributes: [:direct_upload_url])
    end

end