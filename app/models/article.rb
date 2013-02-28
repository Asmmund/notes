class Article < ActiveRecord::Base
  attr_accessible :body, :title
  validates :title,  presence: true, uniqueness: true
  # validates :body, presence: true
end
