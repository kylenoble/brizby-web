class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if @post.postable_type == "business"
        @post.delay.create_activity :create, owner: @business, latitude: @business.latitude, longitude: @business.longitude, category: @business.category
      else
        @post.delay.create_activity :create, owner: @user, latitude: params.fetch(:post)[:latitude], longitude: params.fetch(:post)[:longitude]
      end
    end
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :postable_type, :postable_id, :latitude, :longitude, :tagged_business, images_attributes: [:direct_upload_url])
    end
end
