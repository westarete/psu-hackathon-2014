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

# The methods in this block will be available to the views
helpers do

  # Given a forecast, return a string to represent the type of attire that should be worn.
  def attire(forecast)
    if forecast.icon == 'clear-day'
      "sunglasses"
    elsif forecast.temperature < 40
      "hat"
    elsif forecast.precipProbability >= 0.5
      "raincoat"
    else
      "tshirt"
    end
  end

  # Given a forecast, return the URL of the attire image to display.
  def attire_image_url(forecast)
    "https://raw.githubusercontent.com/westarete/psu-hackathon-2014/master/public/images/#{attire(forecast)}.png"
  end

end

# How we respond to a home page request
get '/' do
  @location = Geocoder.search(params[:location]).first

  if @location
    # Figure out what times we'll use to fetch forecasts.
    start_time = Time.now.to_i + 1*60*60
    lunch_time = Time.now.to_i + 5*60*60
    end_time = Time.now.to_i + 10*60*60

    # Get the forecasts.
    @forecast_start = ForecastIO.forecast(@location.latitude, @location.longitude, :time => start_time).currently
    @forecast_lunch = ForecastIO.forecast(@location.latitude, @location.longitude, :time => lunch_time).currently
    @forecast_end   = ForecastIO.forecast(@location.latitude, @location.longitude, :time => end_time).currently
  end

  erb :index
end
