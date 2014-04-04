require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'geocoder'

# Make sure we're using a gem that works on both Mac and Windows.
MultiJson.use(:json_pure)

get '/' do
  @location = Geocoder.search("penn state").first
  erb :index
end
