class StreamController < ApplicationController

  before_action :ensure_logged_in

  def show
    name = params[:stream_name]
    project = pivotal.fetch_project(params[:id])
    streamer = Streamer.new(pivotal, project, {label: ['internal apis', 'search service']})
    #streamer = Streamer.new(pivotal, project)
    stories = streamer.stream(name)
    presenter = StreamPresenter.new(project.id, name, stories)
    render partial: 'projects/stream',
           locals: { presenter: presenter }
  end
  
end
