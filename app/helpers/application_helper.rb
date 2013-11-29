module ApplicationHelper

  def is_selected?(category, params)
    if params[:controller] == "categories"
      path = category_path(category)
      "selected" if current_page?(path)
    elsif params[:controller] == "blogs" && params[:action] == "show"
      blog = Blog.find(params[:id])
      "selected" if category.id == blog.category.id
    end
  end

  def user_is_admin?
    current_user && current_user.admin?
  end
end
