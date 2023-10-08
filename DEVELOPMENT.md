I'll be collecting my thought process, trying to keep pace with each commit, as I go here:

# First Glance

To me, the barest requirements at first suggest a simple CRUD app with a few has-many and many-to-many relationships that yields and consumes JSON containing user/post/GitHub data, which the front end can then render into components and interfaces.

I'll proceed with Ruby 3.2.2 installed with `asdf` and rails 7.0.8. There are potentially infinite options for a solution here, but I'll use these in the interest of familiarity, time constraints, and not reinventing the wheel.

# Initial setup

It's been a while since I've built with the framework from scratch, so I might run into hitches here and there and have to look things up. I'll be reporting on that too.

As it turns out, I had to do this from the outset. I did a `rails new` and was swiftly reminded that the defaults don't include Postgres as the DB or RSpec as the testing framework, the former of which I'm most accustomed to, the latter of which I want to refresh my knowledge on since it's a very typical standard for Rails apps.

So, I checked the Rails docs and Google to see what my options are.

The docs did give me a `--database` option, but let's see what else I can do since it tells me there's an -h flag to display all the options for `rails new`, not just the small selection in the docs:

	rails new -h | less

Excellent, a less verbose option to specify database, a minimal build for (what for now is) a minimal app, and the option to use SASS, to which I'm also accustomed.

But how about RSpec? Let's check the article I found:

https://medium.com/@cipeinado/how-to-build-a-new-rails-app-with-rspec-postgresql-and-git-1d33c7e60456

Looks like we'll still have to configure Gemfile, but at least from more Googling and doc context we now know that -T skips generating Rails default tests, allowing us to use RSpec instead.

	rails new collidr -d postgresql --minimal --css=sass -T

Let's call it **collidr**, both since colliders create new things and advance our understanding, but also because people may be butting heads a lot with this format.

A git repository is initiated by Rails, nice. We also get a *lot* of dependencies that I'm unsure of. Ideally, I'd remove or simply specify not to add anything extraneous, but for now, my focus is getting a functioning prototype out fast.

	cd collidr
	git status
	git add -A
	git commit -m "Initial commit"
	git remote set origin git@github.com:Coding-Polaris/collidr

After this first commit, I'll set up RSpec per the recipe I linked earlier.

# Initialize RSpec

I'll add both RSpec and an old debugging gem I remember quite liking to Gemfile here, better_errors. When fatal errors are encountered, the gem allows you to step through variable values at every point in the stack with an in-browser debugger.

Naturally, we don't want this turned on anywhere outside of the dev/testing environment, which you can see in Gemfile.

	bundle install

# Is this thing on?

Let's see if we can get a basic Hello World page to load, which I'll remind myself to delete later.

	# routes.rb

	get "/hello_world" to: redirect("/public/hello_world.html")

After *extensive* wrestling with permissions and setup, I finally got the server to stop complaining about postgres not being set up and hit the landing and Hello World pages.
