# Fetches "streams" of stories.
# The streams are 'done', 'in progress' and 'to do'
class Streamer

  def initialize(pivotal_client, project)
    @pivotal_client = pivotal_client
    @project = project
  end

  def done
    # TODO accepted option doesn't seem to work, get 0 results when there should be many
    opts = {current_state: 'accepted'}   # accepted: -3d
    unordered = @pivotal_client.fetch_stories(@project, opts)
    unordered and unordered.sort_by(&:accepted_at).reverse
  end

  def in_progress
    opts = {current_state: 'started,finished,delivered,rejected'}
    @pivotal_client.fetch_stories(@project, opts)
  end

  def todo
    opts = {current_state: 'unstarted'}
    @pivotal_client.fetch_stories(@project, opts)
  end

end

