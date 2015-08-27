class HomeController < ApplicationController

  #skip_authorization_check

  def index
  end

  def create_user
  	@user = User.new(params)
  	if @user.save
  		redirect_to '/'
  	else
  		render :json => { :message => "User couldn't be created" }, :status => 200
  	end
  end
end
