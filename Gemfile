ruby '2.6.6'

####################
# BEGIN:initial gems
####################

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '1.2.3'
gem 'rails', '5.2.4.5'

# Use Puma as the app server
gem 'puma', '5.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '6.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '4.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '5.0.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '5.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.11.2'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '3.35.3'
  gem 'selenium-webdriver', '3.142.7'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '3.7.0'
  gem 'listen', '3.4.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.1.1'
  gem 'spring-watcher-listen', '2.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

###################
# END: initial gems
###################

# BEGIN: gems for docker/test_code
group :development, :testing do
  # gem 'brakeman'
  # gem 'bundler-audit'
  # gem 'gemsurance'
  gem 'rails_best_practices', '1.20.0'
  gem 'rubocop', '1.18.3' # Checks for violations of the Ruby Style Guide, not recommended for legacy apps
  # gem 'sandi_meter'
end
# END: gems for docker/test_code

# Minitest
gem 'minitest', '5.14.4', require: false, group: :testing
gem 'minitest-reporters', '1.4.3', require: false, group: :testing # Adds special features to tests

# BEGIN: Capybara enhancements
group :test do
  gem 'capybara-email', '3.0.2'
  gem 'capybara-slow_finder_errors', '0.1.5'
end
# END: Capybara enhancements

# BEGIN: test coverage
gem 'codecov', '0.5.0', require: false, group: :test
gem 'simplecov', '0.21.2', require: false, group: :test
# END: test coverage

# BEGIN: for docker/outline
group :development do
  gem 'annotate', '3.1.1' # Adds comments listing parameters and the output of "rails routes"
  # gem 'railroady' # Generates block diagrams of controllers
  # gem 'rails-erd' # Generates block diagram of models
end
# END: for docker/outline

# BEGIN: Better Errors
# Provides more and better information in error pages
group :development do
  gem 'better_errors', '2.9.1'
  gem 'binding_of_caller', '1.0.0'
end
# END: Better Errors

gem 'pry-rails', '0.3.9' # Improves the screen output in the Rails console

gem 'email_munger', '0.0.0' # Encodes email address to prevent harvesting by bots

gem 'bootstrap-sass', '3.4.1' # Bootstrap styling

gem 'devise', '4.7.3' # Provides admin/user authentication

# BEGIN: gems used in db/seeds.rb
group :test, :development do
  gem 'faker', '1.9.1' # Generates fake data used for seeding the database
  gem 'ruby-progressbar', '1.11.0' # Provides a progress bar to be used during long loop actions
end
# END: gems used in db/seeds.rb

gem 'jquery-rails', '4.4.0' # Needed for dropdown menus
gem 'timecop', '0.9.4', group: :testing # Changes current time, needed for testing the lock duration

gem 'kaminari', '1.2.1' # For pagination

# Search engine for objects (such as users)
gem 'ransack', '2.4.2'

# BEGIN: for sponsor logos
gem 'carrierwave', '2.1.1' # For uploading files
gem 'mini_magick', '4.11.0' # For resizing images
# END: for sponsor logos
