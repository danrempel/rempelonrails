class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
    prepare_meta_tags title: "Blog", description: "Posts I've written"
		@posts = Post.where(published: true).order("created_at desc").paginate(page: params[:page], per_page: 10)
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
    @post = Post.friendly.find(params[:id])
    prepare_meta_tags(title: @post.title, description: @post.subtitle, keywords: @post_keywords)
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
