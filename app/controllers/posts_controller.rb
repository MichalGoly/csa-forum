class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  # GET /posts/new
  def new
    @post = Post.new
    if params.has_key?(:post_id)
      @post.parent_id = params[:post_id]
    end
    @post.user = current_user.user
    if params.has_key?(:topic_id)
      @post.topic = Topic.find(params[:topic_id])
      @post.title = @post.topic.title
    else
      redirect_to topics_url
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if !params.has_key?(:anonymous)
        @post.user = current_user.user
    end
    current_date = Time.now

    if @post.topic.nil?
      # post in not a reply to a different post
      topic = Topic.new
      topic.title = @post.title
      topic.user = @post.user
      topic.date = current_date
      topic.save
      @post.topic = topic
    end
    @post.date = current_date

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post.topic, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :date, :user_id, :parent_id, :topic_id)
    end
end
