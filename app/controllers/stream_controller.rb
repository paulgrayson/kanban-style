class StreamController < ApplicationController

  def show
    name = params[:stream_name]
    project = pivotal.fetch_project(params[:id])
    streamer = Streamer.new(pivotal, project)
    stories = streamer.stream(name)
    presenter = StreamPresenter.new(project.id, name, stories)
    render partial: 'projects/stream',
           locals: { presenter: presenter }
  end
  
private
  
  def pivotal
    @pivotal_client ||= PivotalClient.new
  end

end
