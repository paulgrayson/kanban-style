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

end
