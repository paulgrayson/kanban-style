class PivotalClient

  def set_token(api_token)
    PivotalTracker::Client.token = api_token
  end

  def fetch_token(email, password)
    PivotalTracker::Client.token(email, password)
  rescue
    false
  end

  def fetch_projects
    PivotalTracker::Project.all
  end

  def fetch_project(id)
    PivotalTracker::Project.find(id.to_i)
  end

  def fetch_stories(project, opts={})
    opts = opts.merge(label: quote_multi_word_labels(opts[:label])) if opts[:label]
    opts[:label] = opts[:label].try(:join, ',')
    # 100 will likely be much more than you ever need but just in case
    opts[:limit] ||= 100
    project.stories.all(opts)
  end

  private

  def quote_multi_word_labels(labels)
    [labels].flatten.map do |label|
      if multi_word_and_not_wrapped?(label)
        "\"#{label}\""
      else
        label
      end
    end
  end

  def multi_word_and_not_wrapped?(label)
    label.include?(' ') && !label.starts_with?('"')
  end
  
end

