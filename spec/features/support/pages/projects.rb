module Pages
  class Projects < Base
    def pretend_signed_in
      page.set_rack_session(api_token: '123')
    end

    def open
      visit projects_path
    end

    def projects
      all('.project-list-item').map(&:text)
    end
  end
end

