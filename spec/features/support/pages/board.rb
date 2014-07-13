module Pages
  class Board < Base
    def open(project_id)
      visit project_path(project_id)
    end

    def project_name
      find('#project-name').text
    end

    def stories(opts={})
      stream = opts.delete(:stream)
      selector = '.story'
      selector = ".stream-#{stream} "+ selector if stream
      all(selector)
    end

    def stream_names
      # capybara/poltergiest seems to give back the CSS (text-transformed: uppercase) version i.e. all CAPS rather than the raw text
      all('.stream-name').map(&:text).map(&:capitalize)
    end
  end
end

