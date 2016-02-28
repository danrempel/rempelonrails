class ProjectsController < ApplicationController
	before_action :find_project, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
    prepare_meta_tags title: "Projects", description: "A list of projects I've completed"
		@projects = Project.all.order("created_at desc")
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params

		if @project.save
			redirect_to @project, notice: "Nice! That project was successfully saved."
		else
			render 'new'
		end
	end

	def show
    @project = Project.friendly.find(params[:id])
    prepare_meta_tags(title: @project.title,  keywords: @project_keywords)
	end

	def edit
	end

	def update
		if @project.update project_params
			redirect_to @project, notice: "Nice! That project was successfully updated."
		else
			render 'edit'
		end
	end

	def destroy
		@project.destroy
		redirect_to projects_path
	end

	private

	def find_project
		@project = Project.friendly.find(params[:id])
	end

	def project_params
		params.require(:project).permit(:title, :description, :link, :slug)
	end
end
