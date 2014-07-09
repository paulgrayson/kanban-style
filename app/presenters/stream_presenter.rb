class StreamPresenter

  def each_story(stream_name, stories)
    return unless block_given?
    last_story = nil
    stories.each do |story|
      show_date_bar = stream_shows_date_bars?(stream_name) && !same_day?(last_story, story)
      yield(story, show_date_bar)
      last_story = story
    end
  end

  def stream_shows_date_bars?(stream_name)
    stream_name == :done
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

end
