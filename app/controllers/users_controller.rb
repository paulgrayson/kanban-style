class UsersController < ApplicationController

  def show
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      api_token = pivotal.fetch_token(@user.email, @user.password)
      if api_token
        SessionUser.set_api_token(session, api_token)
        redirect_to projects_path
      else
        flash.now[:error] = 'Invalid credentials'
        render :show
      end
    else
      render :show
    end
  end

  def destroy
    SessionUser.sign_out(session)
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
