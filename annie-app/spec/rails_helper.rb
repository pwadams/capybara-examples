# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

def sign_in
  @user = User.create(first_name: 'Bob', last_name: 'Sandwich', email: 'bob@sandwich.com', password: 'thisissecure')
  visit root_path
  click_on 'Sign In'
  fill_in :email, with: @user.email
  fill_in :password, with: @user.password
  within("form") { click_on 'Sign In'}
end
