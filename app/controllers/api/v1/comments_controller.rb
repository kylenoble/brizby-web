class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.where('commentable_id = ? AND commentable_type = ?', params[:commentable_id], params[:commentable_type])
                        .page(params[:page])
                        .per(params[:page_size])
  end

  def create
    @comment = Comment.new(comment_params)
    if params[:userable_type] == "user"
      @comment.userable_type = "user"
      @comment.userable_id = comment_params[:userable_id]
    elsif
      @comment.userable_type = "business"
      @comment.userable_id = comment_params[:userable_id]
    end

    if @comment.save 
      render :json => {:state => {:code => 0}, :data => "Successfully commented" }
    else 
      render :json => {:state => {:code => 1, :messages => @comment.errors.full_messages} }, status: 422
    end
  end 

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def query_params
      params.permit(:commentable_type, :commentable_id, :text)
    end

    def comment_params
      params.require(:api_v1_comment).permit(:commentable_type, :commentable_id, :text, :userable_id, :userable_type, :page, :page_size)
    end
end