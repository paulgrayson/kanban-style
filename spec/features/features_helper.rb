require 'rails_helper'
require 'capybara/rails'
require "rack_session_access/capybara"

Dir[Rails.root.join("spec/features/support/**/*.rb")].each { |f| require f }

