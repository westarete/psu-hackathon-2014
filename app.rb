require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'geocoder'
require 'multi_json'

# Make sure we're using a gem that works on both Mac and Windows.
MultiJson.use(:json_pure)

get '/' do
  @location = Geocoder.search(params[:location]).first
  erb :index
end
