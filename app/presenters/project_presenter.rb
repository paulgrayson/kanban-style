class ProjectPresenter

  attr_reader :project

  def initialize(project)
    @project = project
  end

  def streams
    # use AJAX to load the stories later
    # TODO this could just be an array
    @streams ||= {
      done: [],
      in_progress: [],
      todo: []
    }
  end

  def stream_presenter(stream_name, stories)
    StreamPresenter.new(self.project.id, stream_name, stories, true)
  end

end

