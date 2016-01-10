class ProjectInvitationsController < ApplicationController

  def create
    #TODO: validate that :to_user isn't already a member, and current_user is the project owner

    valid_params = invite_params
    error = nil
    if valid_params[:to_user] == nil
      error = 'the user does not exist'
    end

    if ProjectInvitation.find_by(project_id: valid_params[:project_id], to_user: valid_params[:to_user]) != nil
      error = 'the user has already been invited'
    end

    if valid_params[:to_user] == current_user.id
      error = "you can't invite yourself"
    end

    @invitation = ProjectInvitation.new(valid_params)
    if !error && @invitation.save
      flash[:success] = "#{params[:project_invitation][:to_user]} has been invited!"
      redirect_to :back
    else
      flash[:danger] = "Failed to invite #{params[:project_invitation][:to_user]}: #{error}."
      redirect_to :back
    end
  end

  private

    def invite_params
      result = params.require(:project_invitation).permit(:to_user, :message, :project_id)
      result[:from_user] = current_user.id
      to_user = User.find_by_email(params[:project_invitation][:to_user])
      result[:to_user] = to_user ? to_user.id : nil
      result
    end

end
