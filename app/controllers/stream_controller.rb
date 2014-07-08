class StreamController < ApplicationController

  def show
    name = params[:stream_name]
    project = pivotal.fetch_project(params[:id])
    streamer = Streamer.new(pivotal, project)
    stories = streamer.stream(name)
    @presenter = StreamPresenter.new
    render partial: 'projects/stream',
           locals: { stream_name: name, stories: stories }
  end
  
private
  
  def pivotal
    @pivotal_client ||= PivotalClient.new
  end

end
