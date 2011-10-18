source 'http://rubygems.org'

gem 'rails', '3.1.0'

# fix for Error - uninitialized constant Rake::DSL in Ruby Gem
# see http://stackoverflow.com/questions/6268518/uninitialized-constant-rakedsl-in-ruby-gem
#include Rake::DSL if defined?(Rake::DSL)

gem 'compass', git: 'git://github.com/chriseppstein/compass.git'

gem 'facebox-rails'
gem "recaptcha", :require => "recaptcha/rails"


gem 'jquery-rails'
gem 'httparty'
gem 'omniauth'

gem 'databasedotcom'
#leverage the databasedotcom rails helper gem
gem 'databasedotcom-rails'

# sqlite for small stuff, like captcha
gem 'sqlite3'
gem 'pg'  #Heroku force you to use PostgreSQL

group :development, :test do
  gem 'rspec-rails', '~> 2.6'

  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'growl'
  gem 'rb-fsevent'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  #BDD stuff
  gem "cucumber"
  gem "cucumber-rails"
  gem "capybara"
  gem 'minitest'
  gem 'database_cleaner'
end

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end


