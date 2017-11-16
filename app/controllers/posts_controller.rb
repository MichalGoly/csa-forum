class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

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

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
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
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
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
