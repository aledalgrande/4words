source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'therubyracer-heroku'
gem 'omniauth', '~> 0.3.0', :require => "omniauth/oauth"
gem 'koala'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	gem 'sass-rails', "~> 3.1.0"
	gem 'coffee-rails', "~> 3.1.0"
	gem 'uglifier'
end

group :production do
	gem 'pg'
end

group :development do
	gem 'heroku'
	gem 'sqlite3'
	gem 'thin'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
