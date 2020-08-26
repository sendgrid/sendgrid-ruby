require 'simplecov'
SimpleCov.start
require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'faker'

RSpec.configure do |config|
  Dir["#{File.dirname(__FILE__)}/../lib/sendgrid-ruby.rb"].sort.each { |ext| require ext }

  config.color = true
end