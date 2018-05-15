source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
gem 'puma', '~> 3.7'
gem 'uglifier', '>= 1.3.0'

gem 'slim-rails'
gem 'twitter-bootstrap-rails'

gem 'jquery-rails'

gem 'devise'
gem 'devise-i18n'

gem 'rails-i18n'

gem 'carrierwave'
gem 'rmagick'

gem 'faker'
gem 'will_paginate'
gem 'fog-aws'

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'listen'
  gem 'letter_opener'
  gem 'pry'
end
