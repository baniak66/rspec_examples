class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    if params[:sample]
      posts = Posts::UseCases::ImportPosts.new.sample
      render json: posts
    else
      posts = Post.all
      render json: Posts::Representers::Multiple.new(posts).call
    end
  end

  # GET /posts/1
  def show
    render json: Posts::Representers::Single.new(@post).call
  end

  # POST /posts
  def create
    @post = Posts::UseCases::Create.new(post_params).call

    if @post.valid?
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    post = Posts::UseCases::Update.new(params[:id], post_params).call
    if post.errors.any?
      render json: post.errors, status: :unprocessable_entity
    else
      render json: post
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #   render json: { error: "post not found"}
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
