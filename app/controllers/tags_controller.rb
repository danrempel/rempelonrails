class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    if user_signed_in?
      @posts = Post.tagged_with(@tag.name).order("created_at desc").paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.tagged_with(@tag.name).where(published: true).order("created_at desc").paginate(page: params[:page], per_page: 10)
    end
  end
end
