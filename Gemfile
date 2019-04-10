source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'
gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'faraday'
gem 'factory_bot_rails'
gem 'faker'
gem 'figaro'
gem 'omniauth-spotify'
gem 'sidekiq'
gem 'jquery-rails'
gem 'active_model_serializers'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rubocop', '~> 0.66.0', require: false
gem 'twilio-ruby'



group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'launchy'
  gem 'pry'
  gem 'rb-readline'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'bootstrap', '~> 4.3.1'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'skylight'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
