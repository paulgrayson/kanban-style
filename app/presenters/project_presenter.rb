class ProjectPresenter

  attr_reader :project

  def initialize(project, streamer)
    @project = project
    @streamer = streamer
  end

  def streams
    @streams ||= {
      done: @streamer.done,
      in_progress: @streamer.in_progress,
      todo: @streamer.todo
    }
  end

  def stream_presenter(stream_name, stories)
    StreamPresenter.new(stream_name, stories)
  end

end

