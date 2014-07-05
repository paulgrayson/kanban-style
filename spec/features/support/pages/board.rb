module Pages
  class Board < Base
    include Capybara::DSL

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
      all('.stream-name').map(&:text)
    end
  end
end

