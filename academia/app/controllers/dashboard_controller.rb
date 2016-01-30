class DashboardController < ApplicationController
  before_action :authenticate_user
  before_action :validate_logged_in

  def show
    @user = current_user
    @owned_projects = @user.owned_projects
    @projects = @user.projects
    @invitations = @user.project_invitations
  end
end
