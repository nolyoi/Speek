class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 30)
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new(params[:id])
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        if @post.parent
          format.html { redirect_to user_post_path(@post.parent.user, @post.parent), success: 'Post was successfully created.' }
        end
        format.html { redirect_to user_post_path(@post.user, @post), success: 'Post was successfully created.' }
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
      format.html { redirect_to user_path(@post.user), notice: 'Post was successfully destroyed.' }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :user_id, :community_id, :parent_id)
  end
end
