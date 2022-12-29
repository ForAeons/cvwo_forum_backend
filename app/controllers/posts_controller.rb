require File.join(Rails.root, "config", "global_variables.rb")

class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authorized

  # GET /posts
  # def index
  #   @posts = Post.all

  #   render json: @posts
  # end
  # GET /posts?q={query}&cat={category}&page={page_number}
  def index
    if params[:q]
      @posts = Post.where("title LIKE ?", "%#{params[:q]}%").paginate(page: params[:page], per_page: $per_page)
    elsif params[:cat]
      @posts = Post.where(catergory: params[:cat]).paginate(page: params[:page], per_page: $per_page)
    else
      @posts = Post.paginate(page: params[:page], per_page: $per_page)
    end
  
    if @posts.total_pages < params[:page].to_i
      render json: []
    else
      render json: @posts
    end
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # GET /posts/latest/:page
  def lastest
    @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: $per_page)

    if @posts.total_pages < params[:page].to_i
      render json: []
    else
      render json: @posts
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = @user

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
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
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :catergory, :User_id)
    end
end
