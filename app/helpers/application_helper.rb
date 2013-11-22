module ApplicationHelper

  def is_selected?(category_id, params)
    if params[:controller] == "categories"
      path = categories_path(id: category_id)
      "selected" if current_page?(path)
    elsif params[:controller] == "blogs" && params[:action] == "index"
      blog = Blog.find(params[:id])
      "selected" if category_id == blog.category.id
    end
  end
end
