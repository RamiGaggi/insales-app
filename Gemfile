# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 7.0.2', '>= 7.0.2.3'

gem 'bootsnap', require: false
gem 'dry-container'
gem 'faraday'
gem 'faraday-typhoeus'
gem 'importmap-rails' # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'pg'
gem 'pry'
gem 'pry-byebug'
gem 'pry-rails'
gem 'puma', '~> 5.0'
gem 'slim-rails'
gem 'sprockets-rails' # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'stimulus-rails' # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'turbo-rails' # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  gem 'annotate', require: false
  gem 'brakeman', require: false
  gem 'rubocop', '~> 1.27', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'solargraph'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'factory_bot_rails'
end
