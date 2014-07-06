class ProjectsController < ApplicationController

  def index
    @projects = pivotal.fetch_projects
  end

  def show
    project = pivotal.fetch_project(params[:id])
    if project
      streamer = Streamer.new(pivotal, project)
      @presenter = ProjectPresenter.new(project, streamer)
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
