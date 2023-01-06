require File.join(Rails.root, "config", "global_variables.rb")

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]
  skip_before_action :authorized, only: %i[ index show]

  # GET /comments?post_id={post_id}&page={page_number}
  def index
    if params[:post_id]
      @comments = Comment.where(post_id: params[:post_id]).paginate(page: params[:page], per_page: $per_page)
    else
      @comments = Comment.all.paginate(page: params[:page], per_page: $per_page)
    end
  
    if @comments.total_pages < params[:page].to_i
      render json: {error: "No more comments can be found."}
    else
      render json: @comments
    end
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # # GET /posts/:post_id/comments
  # def show_comments_for_post
  #   @post = Post.find(params[:post_id])
  #   @comments = @post.comments
  #   render json: @comments
  # end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.author = @user.username
    @comment.post = Post.find(params[:post_id])

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    # checks for the identity of the user
    if @comment.user_id != @user.id
      render json: { error: 'Unauthorized' }, status: :unauthorized
    elsif @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    # checks for the identity of the user
    if @comment.user_id == @user.id
      @comment.destroy
    else
      render json: { error: 'Unauthorized. You are not the creator of this comment' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
