class Article < ActiveRecord::Base
  attr_accessible :body, :title,:published, :user_id
  validates :title,  presence: true, uniqueness: true
  validates :body, presence: true
  belongs_to :user
end
