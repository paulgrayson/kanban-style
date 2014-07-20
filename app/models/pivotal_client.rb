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
    # 100 will likely be much more than you ever need but just in case
    opts[:limit] ||= 100
    project.stories.all(opts)
  end
  
end

