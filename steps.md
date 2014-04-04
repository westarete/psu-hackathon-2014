---
layout: default
title: Steps for the Ruby/Sinatra Workshop
---

## Glossary

[Ruby](https://www.ruby-lang.org/en/): A general-purpose programming language that was created in the mid-1990's by [Yukihiro "Matz" Matsumoto](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto). Matz designed the language to be powerful and flexible, yet easy to learn and pleasant to use.

RubyGems: A way to package up other developers' Ruby code and share it with others. Each package is called a "gem".

Bundler: The system that Ruby developers use to specify, download, and install RubyGems for your application.

Gemfile: A file that lives in your source code. You use it to tell Bundler which RubyGems to install for your project.

`bundle install`: The command that you use to tell Bundler to install or refresh the gems that are named in your Gemfile.

localhost: This is always the network address of the machine that you're currently working on. So if you visit http://localhost/ , you're trying to visit a website on the machine that you're using. This is useful when you're developing a website on your laptop, because you're usually doing exactly that, over and over and over.

HTML: Stands for Hypertext Markup Language. This is the fundamental language of the web. Web sites serve these documents to browsers, and their job is to render the HTML into what you see when you visit a site. So it's a language to describe the structure and content of a web page, and a way to link to other pages and actions (i.e. hypertext).

## Step 1 - Install our first gems

Create a new file called `Gemfile` and open it in your editor. This is where we tell Bundler which RubyGems to install. Fill it with the following contents:

```ruby
source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
```

This tells Bundler to install [Sinatra](http://www.sinatrarb.com/), a simple web framework for Ruby. Think Rails, but *way* faster and simpler.

Go to the command line in your source directory. Run the following command:

```
bundle install --path vendor/bundle
```

> More info: This will cause the Bundler to go download the Sinatra gems and install them in `vendor/bundle`, which is where Ruby will keep all the gems for your app. Bundler keeps track of exactly which version it installed via the file `Gemfile.lock`. You should keep this file around, but don't edit it directly.

This is the only time we need to specify the path. From here on out when we install more gems, we'll just be able to run `bundle install`.

## Step 2 - Create our initial web app

Create another file next to the Gemfile and call it `app.rb`. This is where we'll create the code that actually runs the core of our application. Fill it with the following contents:

```ruby
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  "Hello, World!"
end
```

Believe it or not, this is enough code to create a complete Ruby web application. To run it, run the following command (again, while in your project's source code directory):

```
ruby app.rb
```

You'll get a message about Sinatra starting, and the program will wait. The web server is now running on your machine and waiting for you to visit it. You can visit it here:

<http://localhost:4567/>

You should see a plain white page with a little "Hello, World!" in the upper left-hand corner.

Now modify the "Hello, World!" text (keep the quotes), hit reload in your browser, and make sure you can see the updated changes.

Congratulations! This is the usual workflow for developing web sites. 

## Step 3 - Introduce a view

Right now we're just returning some plain text from the middle of our application. That's not going to be a good way to build out a site that has an actual design. We want a separate file for our "view". This is where we put the HTML for the web page.

Make a new directory called `views` (all lowercase), and then create a new file called `index.erb` under that. Your project directory structure should now look like this:

```
|
+- Gemfile          (where you specify which gems to load)
+- Gemfile.lock     (created by bundler)
+- app.rb           (where the application code lives)
+- vendor/          (created by bundler)
    +- bundle/
        +- .../
+- views/           (where we keep the html)
    +- index.erb    (our soon-to-be first HTML template)
```     

Open your new `views/index.erb` file in your text editor, and put in the following content:

```html
Hello, <em>World!</em>
```

Now we need to tell the application to use that template when someone visits the home page of the site. Open `app.rb` in your editor and change the last stanza from this:

```ruby
get '/' do
  "Hello, World!"
end
```

to this:

```ruby
get '/' do
  erb :index
end
```

This tells Sinatra to render the view that is named "index". Be sure to include that colon and get the spacing right. 

Reload the page in your browser (<http://localhost:4567/>). You should now see that the word "World" is stylized. We're now serving HTML to the browser from our web app, and we can make that HTML as simple or as complex as we want it to be.

## Step 4 - The static page layout

Now that we can render web pages, let's introduce the skeleton of our web page. It's nice to get the styling in place of what we're going to build first, so we can better visualize what we're creating. At first, it won't do anything -- it will just look pretty. But over the course of the next several steps, we'll gradually increase more and more functionality until we have a working application.

It can take a lot of effort and talent to craft a well-designed web page. So as hackers, we do what any reasonably rushed person would do -- we steal! We're going to use a popular styling framework called [Bootstrap](http://getbootstrap.com/) to define all of the default styling for us. It's reasonably attractive and provides some simple building blocks for us to create our site. You'll probably recognize the style from around the web -- its' a widely used framework.

Beyond using a common framework, it's also extremely common to go find an HTML template online that developers have put out for exactly that purpose. These are often free or cheap, and can be very well done.

Here is an empty template that we'll be using for our application. Note that nothing is "hooked up" at this point. It's pretty to look at, but it's just HTML -- there's no functionality.

Copy and paste the entire contents of this file into your `views/index.erb` (replace the hello world): 

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bicycle Attire</title>

  <!-- Bootstrap -->
  <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body>

<div class="jumbotron">
  <div class="container">
    <h1>You're leaving for work in one hour...</h1>

    <p>
      ...and you're not sure what to wear on your bike commute. Enter your location
      below and we'll help you get dressed.
    </p>

    <div class="row">

      <div class="col-md-6 col-md-offset-2" style="text-align: center">
        <form class="form-inline" role="form" action="/" method="GET">

          <input style="margin-bottom: 20px"
                 class="form-control"
                 name="location"
                 type="text"
                 size="50"
                 placeholder="Enter your location"
                 value="">

          <button style="margin-bottom: 20px"
                  type="submit"
                  class="btn btn-primary">Tell me what to wear</button>

        </form>
      </div>
    </div>

  </div>
</div>

</body>
</html>
```

Reload it in your browser. You should see the initial top banner of our app, and it should look nice, but it shouldn't do anything.

## Step 5 - Install geocoder gem

Now we get to introduce our first piece of functionality. This is a partial step, but an important one. We need to be able to translate a location that the user enters, say "state college, pa", into latitude and longitude coordinates. We will use those coordinates later to request a precise weather forecast for that spot. 

How do we do this? We rely on others' code again. We do a Google search and determine that the [geocoder](http://www.rubygeocoder.com/) gem is the best fit for us. It handles sending our request out to a remote server (in this case Google's geolocation servers), processing the response, and giving the results back to us. The code for us is amazingly simple. 

We need to tell Bundler to install the geocoder gem for us. Open your `Gemfile` again and add the following two lines to the bottom:

```ruby
gem 'geocoder'
gem 'json_pure'
```

Now run `bundle install` on the command line to install the new gems. Bundler will download them from http://rubygems.org and install them in `vendor/bundle` for your app to use.

## Step 6 - Geocode a location

Now we want to use the Geocoder in our application and make sure it's working. Open up your `app.rb` and add the following lines just after the top set of `require` statements:

```ruby
require 'geocoder'
require 'multi_json'

# Make sure we're using a gem that works on both Mac and Windows.
MultiJson.use(:json_pure)
```

That first line loads the gecoder gem into our app (Bundler just installed the gem for us, but this loads it into our app when the app runs).

> The bottom line is a directive that instructs the geocoder gem to use a specific gem that's compatible with both Mac and Windows. This was the result of a problem that we encoutered while developing the app. Like most problems, we described the problem that we were having in a google search, and we found this solution from someone's post who was having  a similar issue.

Stop and restart your Sinatra server (the place where you are running `ruby app.rb`). Pull up that terminal window, and press control-C on Mac, or ctrl-Break on Windows. Sinatra should exit. Then restart it by running  `ruby app.rb` again. Reload the browser and make sure the app still runs. Now the geocoder gem is running in your app.

Now we want to actually geocode an address as a test. It doesn't need to be pretty or powerful yet -- we just want to see if we can talk to the geocoder gem and display an answer. 

While still in `app.rb`, find the `erb :index` line near the bottom. That's where our HTML view gets rendered. Insert a line right before it (but after the `get '/'` statement that looks like this:

```ruby
  @location = Geocoder.search("penn state").first
```

This looks up the first match for the location "penn state", and then saves the results to a variable called `@location`. This is a Ruby instance variable. In the case of Sinatra, this means that that variable will now be available to our view. 
Let's test that theory. Open up `views/index.erb` and go to the bottom of the file. Add a few blank lines before the closing `</body>` and `</html>` tags, and insert this code there:

```html
<p>I found <%= @location.address %>.</p>
<p>It has the lat/lon coordinates <%= @location.latitude %>, <%= @location.longitude %>.</p>
```

Go reload the page and you should see our debug statements at the bottom. Not flexible (we hard-coded the search for "penn state"), and not pretty, but it works! 

## Step 7 - Connecting the form field

Right now we're just hard coding the search for "penn state". Let's connect the form to our search so that we can search for whatever the user enters. Open `app.rb` and change the geolocation line to this:

```ruby
  @location = Geocoder.search(params[:location]).first
```

And as a final nicety, let's also fill in the search box field with whatever was just found last time. In `views/index.erb`, find the line around line 40 that looks like this:

```html
    value="">
```

and change it to this:

```html
    value="<%= @location.address if @location %>">
```

Now when you reload the page, you should be able to search for any location, and the search field should repopulate with what you found.

Notice that if you search for nothing, or if you search for garbage, the application throws an error (it's helpful to try to read these carefully). That's because we don't always get a location back, and our view code is relying on it. That's OK. We'll make it stronger later. For now we're just trying to get things wired up.

## Step 8 - Install Forecast gem

Now it's time to try to get our first weather forecast. We're going to use the awesome [forecast.io](http://forecast.io/) service. I've already signed up for a developer account and bought an API key for us to use (I'll cancel it in a few days to avoid getting a huge bill).

Fortunately, like most good web services, someone has already written a Ruby gem for us to talk to Forecast! Let's add it to the bottom of our `Gemfile`:

```ruby
gem 'forecast_io'
```

And then add the following new `require` line to our `app.rb`, with the other statements like it at the top:

```ruby
require 'forecast_io'
```

We also need to tell the application what our API key is, so that Forecast can track our usage and charge us for the service. Otherwise it won't let us in. Add the following line a bit below the `require` statements in `app.rb`:

```ruby
ForecastIO.api_key = 'dc9060a06370dd03b46af35827653a8c'
```

If you're working on this other than at the 2014 PSU Hackathon, you'll have to register and get your own API key from forecast.io here: <https://developer.forecast.io/> . But those at the Hackathon can use the one above.

Stop and restart your Sinatra server again. Reload the page. It should still work, but it won't have any new functionality yet. If it reloads without any errors, you're ready to go on to the next step.


## Bonus - Deploy your application to Heroku

[Heroku](http://heroku.com) is a hosting service for Rails, Sinatra and other web applications. If you deploy your application there (or at any hosting provider), it can have a public place on the web where other people can visit it. 

In order to do this, we need to create a special configuration file that tells Heroku how to start up the application.

Create a file called `config.ru` and put the following code in it:

```ruby
require './app'
run Sinatra::Application
```

Now you can create a free account at [heroku.com](heroku.com), create a space for your app, and then follow their instructions for pushing the site to their servers so that it's hosted there. 

You can see an example of this application hosted at Heroku here: 

http://bike-attire.herokuapp.com/
