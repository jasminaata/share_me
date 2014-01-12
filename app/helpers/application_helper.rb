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

  def user_is_author?(comment)
    user_signed_in? && current_user.id == comment.user_id
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true )
    markdown.render(text).html_safe
  end
end
