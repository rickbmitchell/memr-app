class PostsController < ApplicationController

  def index
    @post = Post.all.where(:created_at => (Time.zone.now.beginning_of_week..Time.zone.now.end_of_week))
    @profile = Profile.where(user_id: params[:id]).first
  end

  def all
    @post = Post.all.where(:created_at => (Time.zone.now.beginning_of_week..Time.zone.now.end_of_week))
  end

  # def archive
  #   @post = Post.last_week.votes.count.reverse.first(1)
  # end

  def new
    @post = Post.new
    @current_image_url = Meme.get_current_meme.avatar.url(:medium)
    @max_top = Post.validators_on( :top_text ).first.options[:maximum]
    @max_bottom = Post.validators_on( :bottom_text ).first.options[:maximum]
  end

  def show
    @post = get_post
  end

  def edit
    @post = get_post
    @current_image_url = Meme.get_current_meme.avatar(:medium)
    @max_top = Post.validators_on( :top_text ).first.options[:maximum]
    @max_bottom = Post.validators_on( :bottom_text ).first.options[:maximum]
  end

  def create
    if current_user
      if Time.now.end_of_week > Time.now
        @post = Post.create(post_params)
        @post.two_line_meme(top_params[:top_text], bottom_params[:bottom_text])
        @post.avatar = File.open(Rails.root + "public/memes/#{@post.to_param}entry.jpg", "rb")
        if @post.save
          redirect_to post_path(@post.id)
        else
          flash[:alert] = "There was a problem"
          redirect_to 'posts/new'
        end
      end
    end
  end

  def update
    @post = get_post
    if current_user.id == @post.user_id
      @post.update(post_params)
        redirect_to post_path(params[:id]), notice: "Your meme was updated."
    else
        redirect_to root_path, alert: "Not your meme."
    end
  end

  def destroy
    @user = current_user
    @post = get_post
    @post.destroy
    redirect_to user_path(@user), notice: "Your entry was deleted."
  end

  def upvote
    # @vote = Vote.create(user_id: current_user.id, post_id: params[:post_id])
    @post = get_post
    if user_signed_in?
      @post.votes.create(user_id: current_user.id, post_id: params[:id])
    end
    if !user_signed_in?
      @post.votes.where(user_ip_address: request.remote_ip).empty?
      @post.votes.create(post_id: params[:id])
    end
    respond_to do |format|
      format.js
      format.html
    end
    # @vote = Vote.create(user_id: current_user.id, post_id: params[:post_id])
    # @post.votes.create
    # redirect_to post_path(params[:id])
  end

  private

  def get_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:top_text, :bottom_text, :avatar).merge(user_id: current_user.id)
  end

  def top_params
    params.require(:post).permit(:top_text).merge(user_id: current_user.id)
  end

  def bottom_params
    params.fetch(:post).permit(:bottom_text).merge(user_id: current_user.id)
  end

end
