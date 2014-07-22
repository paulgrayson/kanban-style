class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def ensure_logged_in
    if session[:api_token].blank?
      if request.xhr?
        render text: 'Unauthorized', status: 401
      else
        redirect_to root_path
      end
    else
      pivotal.set_token(session[:api_token])
    end
  end

private
  
  def pivotal
    @pivotal_client ||= PivotalClient.new
  end

end
