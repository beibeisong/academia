class ProjectJoinRequestsController < ApplicationController

  before_filter 'validate_logged_in'

  def create
    valid_params = request_params
    error = nil


    @request = ProjectJoinRequest.new(valid_params)
    if !error && @request.save
      flash[:success] = 'You have requested to join the group!'
      redirect_to :back
    else
      flash[:danger] = "Failed to request to join the group: #{error}."
      redirect_to :back
    end

  end

  private

    def request_params
      result = params.require(:project_join_request).permit(:project_id)
      result[:from_user] = current_user.id
      result
    end

end
