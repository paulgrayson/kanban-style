class PivotalClient

  def fetch_token(user_credentials)
    PivotalTracker::Client.token(user_credentials['email'], user_credentials['password'])
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

