class PivotalClient

  def fetch_projects
    PivotalTracker::Project.all
  end

  def fetch_project(id)
    PivotalTracker::Project.find(id.to_i)
  end

  def fetch_stories(project, opts)
    project.stories.all(opts)
  end
  
end

