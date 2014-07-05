module Pages
  class Board < Base
    include Capybara::DSL

    def open(project_id)
      visit project_path(project_id)
    end

    def project_name
      find('#project-name').text
    end

    def stories
      all('.story')
    end
  end
end

