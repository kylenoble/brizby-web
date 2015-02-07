class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def query_params
      params.permit(:deal_id, :user_id, :business_id, :text)
    end

    def comment_params
      params.require(:comment).permit(:deal_id, :user_id, :business_id, :text)
    end
end