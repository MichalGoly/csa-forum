class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  def post_wrappers
    # 1. Iterate over all posts of the topic
    # 2. Recursively find the number of parent nodes for each Post
    # 3. Set the number as the offset, add to out
    # 4. Return out
    out = Array.new
    self.posts.each do |p|
      offset = p.number_of_parents
      out.push(PostWrapper.new(p, offset))
    end
    return out
  end
end

class PostWrapper
  attr_accessor :post, :offset
  def initialize(post, offset)
    @post = post
    @offset = offset
  end
end
