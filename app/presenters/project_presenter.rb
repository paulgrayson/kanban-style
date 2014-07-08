class ProjectPresenter < StreamPresenter

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

end

