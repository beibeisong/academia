class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      log_in @project
      flash[:success] = 'Project created successfully!'
      redirect_to @project
    else
      render 'new'
    end
  end

  def new
    @project = Project.new
  end

  def join
    @project = Project.find(params[:project_id])
    @project.users << current_user
    redirect_to @project
  end

  private

    def project_params
      result = params.require(:project).permit(:title, :description)
      result[:user_id] = current_user.id
      result
    end

end
