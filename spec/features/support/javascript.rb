# Enable capybara and poltergeist (phantomjs)
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'database_cleaner'
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
    Capybara.javascript_driver = :poltergeist
  end

  config.before :each do |example|
    # js tagged use truncation
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after :each do
    DatabaseCleaner.clean
  end

end

