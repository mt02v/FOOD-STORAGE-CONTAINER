class PostsController < ApplicationController

  before_action :set_post, only: %i[edit update destroy]
  before_action :move_to_signed_in, except: [:top]

  def index
    if params[:from_memo].present?
      # 在庫の追加
    Post.create(product: params[:title], memo: params[:content], start_time: Date.today, user_id: current_user.id)
    end
    @genres = Genre.all
    @posts = params[:name].present? ? Genre.find(params[:name]).posts.where(user_id: current_user.id) : Post.where(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    @post_genre = PostGenre.create(post_id: @post.id, genre_id: params[:post][:genre_ids], user_id: @post.user_id)

      redirect_to posts_path, notice: "#{@post.product}を追加しました"
    else
      flash.now[:alert] = "追加に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    @post.post_genres.destroy_all
     PostGenre.create(post_id: @post.id, genre_id: params[:post][:genre_ids], user_id: @post.user_id)
    if @post.update(post_params)
      redirect_to posts_path, notice: "#{@post.product}を更新しました"
    else
      flash.now[:alert] = "更新しました"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, alert: "#{@post.product}を削除しました"
  end

  def show
    #byebug
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:product, :memo, :start_time,  user_id: @current_user.id)
  end

  def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to "/users/sign_in"
    end
  end
end