class Blog < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :category
end
