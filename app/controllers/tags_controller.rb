class TagsController < ApplicationController
  def index
    prepare_meta_tags title: "Tag:", description: @tag.name
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.tagged_with(@tag.name).order("created_at desc").paginate(page: params[:page], per_page: 10)
    prepare_meta_tags(title: @tag.name, description: @tag.name, keywords: @tag_keywords)
  end
end
