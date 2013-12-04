class CommentsController < ApplicationController
  before_filter :blog
  before_filter :authenticate_user!, only: [:create]

  def blog
    @blog = Blog.find(params[:blog_id])
  end

  def create
    @comment = Comment.new comment_params
    @comment.blog_id = @blog.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: "You commented on a blog!" }
      else
        format.html { redirect_to blog_path(@blog), notice: "There was an error commenting!" }
      end
    end
  end

  def destroy
  end

  private 

  def comment_params
    params.require(:comment).permit(:body, :blog_id)
  end

end
