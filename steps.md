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

Copy and paste the entire contents of this file into your `views/index.erb`: 

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
