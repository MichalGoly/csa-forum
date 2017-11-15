class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  def post_wrappers
    # 1. Iterate over all posts of this topic
    # 2. Find the parent node
    # 3. Create an empty array for the output
    # 4. Perform a traversal over the nodes
    # 5. At each node, find the depth, construct a PostWrapper and store in out
    root = nil
    self.posts.each do |p|
      if p.is_parent
        root = p
        break
      end
    end
    out = Array.new
    traverse(root, out)
    return out
  end

  def traverse(root, out)
    offset = root.number_of_parents
    out.push(PostWrapper.new(root, offset))
    if root.children.exists?
      sorted = root.children.sort_by(&:date)
      sorted.each do |child|
        self.traverse(child, out)
      end
    end
  end
end

class PostWrapper
  attr_accessor :post, :offset
  def initialize(post, offset)
    @post = post
    @offset = offset
  end
end
