require 'bundler/setup'
Bundler.require(:default)

require 'yaml'
require 'sinatra'
require 'sinatra/json'
require 'json'
require 'right_aws'

require File.dirname(__FILE__) + "/initializers/aws_initializer.rb"
require File.dirname(__FILE__) + "/lib/queue.rb"
require File.dirname(__FILE__) + "/riskified_webhooks.rb"

map '/' do
  run RiskifiedWebhooks
end