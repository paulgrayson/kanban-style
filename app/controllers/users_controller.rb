class UsersController < ApplicationController

  def create
    api_token = pivotal.fetch_token(user_params)
    if api_token
      session[:api_token] = api_token
      redirect_to projects_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:api_token] = nil
    redirect_to root_path
  end

  private

  def pivotal
    pivotal = PivotalClient.new
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
