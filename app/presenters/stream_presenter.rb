class StreamPresenter

  attr_reader :stream_name

  def initialize(project_id, stream_name, stories, loading=false)
    @project_id = project_id
    @stream_name = stream_name
    @stories = stories
    @loading = loading
  end

  def human_stream_name
    ActiveSupport::Inflector::humanize(stream_name)
  end

  def data_uri
    Rails.application.routes.url_helpers.stream_project_path(id: @project_id, stream_name: self.stream_name)
  end

  def each_story
    return unless block_given?
    last_story = nil
    @stories.each do |story|
      show_date_bar = stream_shows_date_bars?(@stream_name) && !same_day?(last_story, story)
      yield(story, show_date_bar)
      last_story = story
    end
  end

  def stream_shows_date_bars?(stream_name)
    stream_name.downcase.to_sym == :done
  end

  def same_day?(story_a, story_b)
    if story_a.nil? || story_b.nil?
      false
    else
      story_a.accepted_at.to_date == story_b.accepted_at.to_date
    end
  end

  def story_labels(story)
    if story.labels
      story.labels.split(',').sort
    else
      []
    end
  end

  def show_nothing_to_see_message?
    !@loading && @stories.empty?
  end

end

