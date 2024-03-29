source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2', '>= 5.2.2.1'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 4.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# AASM - State machines for Ruby classes
gem 'aasm'

# Flexible authentication solution for Rails with Warden.
gem 'devise'

# JWT
gem 'devise-jwt'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS)
# making cross-origin AJAX possible
gem 'rack-cors'

# We use Cloudflare to back our domains
gem 'cloudflare', require: false

group :development, :test do
  # Load environment variables from .env into ENV in development
  gem 'dotenv-rails'

  # Copies an initializer to every rails project
  gem 'pry-rails'

  # Testing framework
  gem 'rspec-rails'

  # Used to seed data in test environments
  gem 'ffaker', require: false

  # Test fixtures
  gem 'factory_bot_rails'

  # Code coverage
  gem 'simplecov', require: false

  # One-liner RSpec helper
  gem 'shoulda-matchers'

  # Controller matchers
  gem 'rails-controller-testing'

  # Format RSpec results in JUnit format for circleci
  gem 'rspec_junit_formatter'
end

group :development do
  # Static code analysis
  gem 'rubocop', require: false

  # FS changes listener
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your app running in the background.
  gem 'spring'

  # Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Detect N+1 issues
  gem 'bullet'

  # Solargraph for dev
  gem 'solargraph'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
