class BlogsController < ApplicationController

  def index
    @blog = Blog.find(params[:id])
    @category = Category.find(@blog.category_id)
  end

  def show 
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
      blog = Blog.new blog_params
    if blog.save
      redirect_to action: 'show', notice: "You created a blog!"
    else
      redirect_to :back, notice: 'There was an error creating the blog!'
    end
  end

  private 

  def blog_params
    params.require(:blog).permit(:title, :body, :category_id)
  end
end