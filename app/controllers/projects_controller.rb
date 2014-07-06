class ProjectsController < ApplicationController

  def index
    @projects = pivotal.fetch_projects
  end

  def show
    @presenter = ProjectPresenter.new(pivotal, params[:id])
    if @presenter.found_project?
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

end
