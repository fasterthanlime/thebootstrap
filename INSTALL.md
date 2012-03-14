
## So what does the bootstrap run?

the bootstrap runs on Rails 3.2, sqlite (more than enough).

It uses omniauth and omniauth-twitter for authentication, date.js for client-side date parsing, haml and scss for markup.

In production, it runs on unicorn, with a front-facing nginx instance that serves static assets (with proper caching) and proxies other requests to unicorn.

## Basic dev set up

First things first: you're going to need to register a Twitter app
at the [Twitter dev center](https://dev.twitter.com/). You only need Read-only access.

A really quick primer:

    git clone git://github.com/nddrylliog/thebootstrap.git
    cd thebootstrap

You can fork your own, pull requests are welcome

    rvm use 1.9.2

It's all in the .rvmrc anyway

    bundle install

You might want to edit `config/database.yml` at this point, although the defaults should be sane.

    cp config/credentials{.sample,}.yml

You definitely want to edit `config/credentials.yml` and replace with your actual Twitter key and secret, though.

    rake db:migrate

That's it! Now if you run

    rails s

your app should be running at `http://localhost:8338`

## Why basic dev setup is evil

Accessing your app through a port on localhost is nasty. Don't do it!

For starters, it's ugly on the eyes. Who wants to see a dev screenshot of you running localhost:something? Don't do it!

Also, and more importantly, OAuth APIs like Twitter make you specify callback URLs, and whitelist that one.

To combat this, two things: first, drop a line like this in your `/etc/hosts` file:

    127.0.0.1   example.org

(Where example.org is your actual domain name, of course)

And then set up nginx as described in the next paragraph:

## Setting up nginx as a reverse proxy

A set of config files for both staging (beta) and production is available
in `config/nginx`

    cp config/nginx/* /etc/nginx/sites-available/

Then edit `/etc/nginx/sites-available/*thebootstrap*` for correct paths, correct `server_name` (which should be set to your domain name), and to double-check the config (always good to know what's running on your server).

    ln -s /etc/nginx/sites-{available,enabled}/thebootstrap.ch
    ln -s /etc/nginx/sites-{available,enabled}/beta.thebootstrap.ch

To start the production server, do:

    rake unicorn:start

It will start unicorn using the config file in `config/unicorn.rb`, as a daemon. In production, unicorn doesn't reload automatically your source: to hot-reload after a deploy, simply do a:

    rake unicorn:reload

It will kill -s USR2 the master unicorn process, causing it to reload its workers processes after they finish processing their current request.

You can completely stop unicorn with

    rake unicorn:stop

but honestly, who would want to do that?

## Other tips

If you're looking for a great free DNS service, try [freedns.afraid.org](http://freedns.afraid.org).

Don't curse at Rails, it will only bite back.

How long has it been since you last drank a hot chocolate? Those things are delicious.

If you read it this far, you should probably [follow me on Twitter](https://twitter.com/nddrylliog)

