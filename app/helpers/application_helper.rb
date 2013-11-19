module ApplicationHelper
  def is_selected?(path)
    "selected" if current_page?(path)
  end
end
