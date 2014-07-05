class ProjectsController < ApplicationController

  def index
    @projects = pivotal.fetch_projects
  end

  def show
    @project = pivotal.fetch_project(params[:id])
    @streams = create_streams(@project)
    p @streams[:done]
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

  def create_streams(project)
    streamer = Streamer.new(pivotal, project)
    {
      done: streamer.done,
      in_progress: streamer.in_progress,
      todo: streamer.todo
    }
  end

end
