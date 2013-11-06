class AddCategoryRefToBlogs < ActiveRecord::Migration
  def change
    add_reference :blogs, :category, index: true
  end
end
