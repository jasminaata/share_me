class Blog < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true, uniqueness: true
  belongs_to :category
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader
end
