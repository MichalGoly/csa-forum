class API::TopicsController < API::ApplicationController

  # before_action :set_current_page, except: [:index]
  before_action :set_topic, only: [:show, :update]
  # before_action :admin_required, only: [:index, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :show_record_not_found

  # GET /api/topics.json
  def index
    if params.key?(:all)
      @topics = Topic.all.order('date DESC')
    else
      @topics = Topic.paginate(page: params[:page], per_page: params[:per_page])
                  .order('date DESC')
    end
  end

  # GET /api/topics/1.json
  def show
    respond_to do |format|
      format.json
    end
  end

  # POST /api/topics.json
  def create
    @post = Post.new(post_params)
    if !params.has_key?(:anonymous)
        @post.user = current_user.user
    end
    current_date = Time.now

    if @post.topic.nil?
      # post in not a reply to a different post
      @topic = Topic.new
      @topic.title = @post.title
      @topic.user = @post.user
      @topic.date = current_date
      @topic.save
      @post.topic = @topic
    end
    @post.date = current_date

    respond_to do |format|
      if @post.save
        format.json { render :show, status: :created, location: @topic }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/topics/1.json
  def update
    if current_user.id == @user.id || is_admin?
      respond_to do |format|
        format.json do
          @image = @user.image
          @service = ImageService.new(@user, @image)
          if @service.update_attributes(user_params, params[:image_file])
            head :created
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
      end
    else
      indicate_illegal_request I18n.t('users.not-your-account')
    end
  end

  # DELETE /api/topics/1.json
  def destroy
    respond_to do |format|
      format.json do
        @user.destroy
        head :no_content
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def indicate_illegal_request(message)
    respond_to do |format|
      format.json {
        render json: "{#{message}}",
               status: :unprocessable_entity
      }
    end
  end

  def show_record_not_found(exception)
    respond_to do |format|
      format.json {
        render json: '{Thread does not exist.}',
               status: :unprocessable_entity
      }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # Note that the user_details_attributes call used in the non-API UsersController
  # class did not work for REST client requests. It may be that nested attributes
  # as supported by the nested_attributes call in the User model may not work
  # with non-form based requests. Further investigation is required. Consequently,
  # the data is sent in a unnested form and the objects created and tied
  # together explicitly in the create action.
  def post_params
    params.require(:post).permit(:title, :body, :date, :user_id, :parent_id, :topic_id)
  end

end
