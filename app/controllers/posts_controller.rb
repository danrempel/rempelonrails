class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
    if user_signed_in?
      @posts = Post.all.order("created_at desc").paginate(page: params[:page], per_page: 10)
      if params[:search]
        @posts = Post.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      else
        @posts = Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
      end
    else
		  @posts = Post.where(published: true).order("created_at desc").paginate(page: params[:page], per_page: 10)
      if params[:search]
        @posts = Post.search(params[:search]).where(published: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      else
        @posts = Post.all.where(published: true).order('created_at DESC').paginate(page: params[:page], per_page: 10)
      end
    end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new post_params

		if @post.save
			redirect_to @post, notice: "Aww yisss... Your article was successfully saved!"
		else
			render 'new', notice: "Oh no, dude! I was unable to save your post."
		end
	end

	def show
    if user_signed_in?
      @post = Post.friendly.find(params[:id])
    else
      @post = Post.where(published: true).friendly.find(params[:id])
    end
	end

	def edit
	end

	def update
		if @post.update post_params
			redirect_to @post, notice: "Awesome! Your article was successfully saved!"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title, :subtitle, :published, :content, :tag_list, :slug)
	end

	def find_post
		@post = Post.friendly.find(params[:id])
	end
end
