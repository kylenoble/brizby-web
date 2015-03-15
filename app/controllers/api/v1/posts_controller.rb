class Api::V1::PostsController < Api::V1::BaseController

	private

    def set_post
      @post = Post.find(params[:id])
    end

    def query_params
	    params.permit( :postable_id, :postable_type, :tagged_business)
	  end

    def post_params
      params.require(:post).permit(:body, :postable_type, :postable_id, :latitude, :longitude, :tagged_business, images_attributes: [:direct_upload_url])
    end

end