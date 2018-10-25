source 'https://rubygems.org'


# Rails, MySQL, Puma
gem 'rails', '~> 5.2.0'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'

# Rails Dependencies
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# loads rails apps faster 
gem 'bootsnap', '>= 1.1.0', require: false

# Application Specific 
# =====================================================================================

gem 'sanitize'

# interface items
gem 'paperclip', '~> 6.0.0'

# cas client
gem 'rack-cas', '~> 0.16.0'

# frontend
gem 'font-awesome-sass'

# searching / indexing for speeds / pagination for elegance
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
  
# Test Suite
# =====================================================================================
group :test do
  # RSpec & testing gems!
  gem 'rspec-rails', '~> 3.7'
  
  # simplecov
  gem 'simplecov'
  gem 'simplecov-console'  
  
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end  
  
# Developoment / Test Items (Primarily debugging)
# =====================================================================================    
group :development, :test do  
  gem 'shoulda-matchers', '~> 3.1'

  # For test data generation
  gem "factory_bot_rails", "~> 4.0"
  
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # from rails new
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
