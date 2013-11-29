class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
    
  end

  def show 
    @blog = Blog.find(params[:id])
    @category = @blog.category
  end

  def new
    @blog = Blog.new
  end

  def create
      blog = Blog.new blog_params
    if blog.save
      redirect_to action: 'index', notice: "You created a blog!"
    else
      redirect_to :back, notice: 'There was an error creating the blog!'
    end
  end

  def edit
    @blog = Blog.find(params[:id])  
  end

  def update
    blog = Blog.find(params[:id])

    respond_to do |format|
      if blog.update_attributes( blog_params )
        format.html { redirect_to blog, notice: "Blog was successfully updated." }
      else
        redirect_to action: 'edit'
      end
    end
  end

  private 

  def blog_params
    params.require(:blog).permit(:title, :body, :category_id)
  end
end