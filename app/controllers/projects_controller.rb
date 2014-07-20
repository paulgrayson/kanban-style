class ProjectsController < ApplicationController

  before_action :ensure_logged_in
  
  def index
    if request.xhr?
      @projects = pivotal.fetch_projects
      render :index, layout: false
    else
      @projects = []
      render :index, layout: true
    end
  end

  def show
    project = pivotal.fetch_project(params[:id])
    if project
      @presenter = ProjectPresenter.new(project)
      render :show 
    else
      flash[:error] = 'Unknown project id'
      redirect_to projects_path
    end
  end

private
  
  def pivotal
    @pivotal_client ||= PivotalClient.new
  end


  def ensure_logged_in
    if session[:api_token].blank?
      redirect_to root_path
    else
      pivotal.set_token(session[:api_token])
    end
  end

end
