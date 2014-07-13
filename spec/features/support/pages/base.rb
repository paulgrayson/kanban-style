module Pages
  class Base
    include Rails.application.routes.url_helpers
    include Capybara::DSL
  end
end
