class Topic < ApplicationRecord
  validates_presence_of :title, :date

  belongs_to :user, :optional => true
  has_many :posts, dependent: :destroy

  self.per_page = 8

  def mark_read_posts(user_id)
    # 1. Get all unread posts for this topic by the logged in user
    # 2. Iterate over them and insert into PostsRead
    u_posts = unread_posts(user_id)
    u_posts.each do |p|
      pr = PostsRead.new
      pr.user_id = user_id
      pr.post_id = p.id
      pr.topic_id = self.id
      pr.save
    end
  end

  def unread_posts(user_id)
    # 1. Get all posts of this topic
    # 2. Get all PostsRead for the logged in user of this topic
    # 3. Extract post IDs of the PostsRead
    # 4. Get all Posts which has been read by the logged in user
    # 5. Return the difference of total_posts and read_posts back to the caller
    total_posts = self.posts
    posts_read = PostsRead.where(user_id: user_id, topic_id: self.id)
    ids = []
    posts_read.each do |pr|
      ids.push(pr.post_id)
    end
    read_posts = Post.where(id: ids)
    return total_posts - read_posts
  end

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
