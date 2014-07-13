module Pages
  class Projects < Base
    def open
      visit projects_path
    end

    def projects
      all('.project-list-item').map(&:text)
    end
  end
end

