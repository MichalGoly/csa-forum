class PostsRead < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  belongs_to :post
end
