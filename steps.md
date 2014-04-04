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

http://localhost:4567/

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
