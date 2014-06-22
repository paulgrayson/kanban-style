class ProjectsController < ApplicationController

  def index
    @projects = fetch_projects
  end

  def show
    @project = fetch_project(params[:id])
    if @project
      render :show 
    else
      flash[:error] = 'Unknown project id'
      redirect_to projects_path
    end
  end

  private

  def fetch_projects
    PivotalTracker::Project.all
  end

  def fetch_project(id)
    puts "in fetch_project"
    PivotalTracker::Project.find(id.to_i)
  end

end
