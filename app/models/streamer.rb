# Fetches "streams" of stories.
# The streams are 'done', 'in progress' and 'to do'
class Streamer

  def initialize(pivotal_client, project, filters=nil)
    @pivotal_client = pivotal_client
    @project = project
    @filters = filters || {}
  end

  def stream(name)
    self.send(name.to_sym)
  end

  def done
    # TODO accepted option doesn't seem to work, get 0 results when there should be many
    opts = {current_state: 'accepted'}   # accepted: -3d
    opts.merge!(@filters)
    unordered = @pivotal_client.fetch_stories(@project, opts)
    unordered and unordered.sort_by(&:accepted_at).reverse
  end

  def in_progress
    opts = {current_state: 'started,finished,delivered,rejected'}
    opts.merge!(@filters)
    @pivotal_client.fetch_stories(@project, opts)
  end

  def todo
    opts = {current_state: 'unstarted'}
    opts.merge!(@filters)
    @pivotal_client.fetch_stories(@project, opts)
  end

end

