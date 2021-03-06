class ProjectsController < ApplicationController

  before_filter 'validate_logged_in'

  def show
    @project = Project.find(params[:id])
    @is_owner = @project.user_id == current_user.id
    if @is_owner
      @new_invitation = ProjectInvitation.new
    end
    @invitation = ProjectInvitation.find_by(project_id: @project.id, to_user: current_user.id)
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
    @project.users << current_user unless current_user.in? @project.users
    redirect_to @project
  end

  private

    def project_params
      result = params.require(:project).permit(:title, :description)
      result[:user_id] = current_user.id
      result
    end

end
