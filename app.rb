require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'geocoder'
require 'multi_json'
require 'forecast_io'

# Set our API key for talking to forecast.io
ForecastIO.api_key = 'dc9060a06370dd03b46af35827653a8c'

# Make sure we're using a gem that works on both Mac and Windows.
MultiJson.use(:json_pure)

get '/' do
  @location = Geocoder.search(params[:location]).first
  if @location
    @forecast = ForecastIO.forecast(@location.latitude, @location.longitude).currently
  end
  erb :index
end
