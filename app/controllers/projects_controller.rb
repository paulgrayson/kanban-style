class ProjectsController < ApplicationController

  def index
    @projects = pivotal.fetch_projects
  end

  def show
    @project = pivotal.fetch_project(params[:id])
    @stories = pivotal.fetch_stories(@project)
    if @project
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
