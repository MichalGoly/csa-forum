class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  def index
    @topics = Topic.paginate(page: params[:page], per_page: params[:per_page])
                .order('date DESC')
  end

  # GET /topics/1
  def show
    @current_page = params[:page]
  end

  # GET /topics/new
  def new
    @post = Post.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /topics/1
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    respond_to do |format|
      if is_owner_or_admin(@topic)
        @topic.destroy
        format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      else
        format.html { redirect_to topics_url, notice: 'You are not the owner of this thread!' }
      end
    end
  end

  def is_owner_or_admin(topic)
    if topic.user.nil? && is_admin?
      return true
    elsif (!topic.user.nil? && (is_admin? || topic.user.id == current_user.id))
      return true
    else
      return false
    end
  end

  helper_method :is_owner_or_admin

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :date, :user_id)
    end
end
