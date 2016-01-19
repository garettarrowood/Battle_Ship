source 'https://rubygems.org'

gem 'rails', github: "rails/rails"
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'devise', git: 'https://github.com/plataformatec/devise.git'
gem 'responders'
gem 'puma'
gem "sprockets"
gem "sprockets-es6"
gem 'gon'
gem 'rails_12factor', group: :production

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'pry'
  gem 'byebug'
  gem 'pry-byebug'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'konacha'
  gem 'selenium-webdriver'
  gem 'sprockets-rails', '< 3.0.0' # Solves compatibility issue with Konacha 3.7.0
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.2.3"
