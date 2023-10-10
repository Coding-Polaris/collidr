I'll be collecting my thought process, trying to keep pace with each commit, as I go here.

This is very stream-of-consciousness - I'll be creating a more structured
overview of the project toward the end.

# First Glance

To me, the barest requirements at first suggest a simple CRUD app with a few has-many/belongs-to and many-to-many relationships that yields and consumes JSON containing user/post/GitHub data, which the front end can then render into components and interfaces.

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

After *extensive* wrestling with first-time-postgres-install permissions and config, I finally got the server to stop complaining about it not being set up and hit the landing and Hello World pages.

# The business

## Overall data layout/relationships

Let's start with the DB structure and relationships of the tables we'll be using, then start implementing and testing them one by one.
Eventually we will have to integrate these and test those integrations.

Integer primary keys are assumed.

Headcanon for my schema (will evolve with commits):

	user name:varchar(24)(unique + indexed) email:string github_name:varchar(39) description:text rating:decimal timestamps
		has_many :posts
		has_many :comments
		has_many :direct_messages
		has_many :activity_items
		# might implement, in any case it's mandatory for standard social media apps
		has_many :blocked_users, through: :blocks 
		has_and_belongs_to_many :ratings
		has_many :ratings_rater, as: :rater
		has_many :ratings_ratee, as: :ratee

	activity_item user_id:integer (indexed) activity_time:datetime (indexed) invoker_id:integer invoker_type:string description:varchar(255) timestamps

	post user_id:integer (indexed) title:varchar(128) body:text timestamps
		belongs_to :user

	comment user_id:integer indexed post_id: timestamps

	rating stars:integer rater_id:integer (user_id, indexed) ratee_id:integer (user_id, indexed) timestamps
		has_one :user, as: :rater
		has_one :user, as: :ratee

Other things I might add later, if I have the time:

	block blocker_id:integer (indexed) blocked_id:integer (indexed) unique constraint on pair
polymorphic!

	favorite favorited_id:integer favorited_type:string (must be in user, post, comment)

# Initializing users

What stands out immediately are that we will need (or may find very desirable) several more features not explicitly listed in the original design requirements. In particular:

  - User authentication; create signup, login, and email verification. Are you who you say you are?
  - Authentication with GitHub. Is that really your GitHub account?
  - A User directory with sorting, searching, and pagination

I'll actually get around to developing these later in the process since, again, rolling auth from scratch is something I'm not used to doing - but what's important for now is writing it down.

		rails g scaffold User

I fleshed out the initial migration, added some basic validations to the model, and after some fiddling with RSpec, got the initial model tests to pass.

I had a lot of relearning RSpec to do, picked up shoulda along the way, and rewrote the test suite to be a lot less verbose and more DRY - ditto for the model's initial validations.

# Intitializing ActivityItem

Given that history will be central to this app, I thought I had might as well lay the foundation for this first.

This will be the nexus through which many different objects chronicle history; ActivityItem will be invoked from
other models when the relevant activities outlined in the requirements are made.

# Actually drawing a schema

It was at this point I realized formally definining the structure of the app was probably a better idea from the outset.

I found an online tool, DrawSQL, that can convert the output from `rake db:schema:dump` to a drawn schema. This will greatly speed up being able to structure and implement my apps; ideally a tool that lets me expand this to visualizing and checking off things like the MVC would make the process much more streamlined and structured than it's been up to this point.

# Annotating models

I've found it helpful throughout my career to have the table I'm looking at available at a glance in the model file.

The annotate gem accomplishes this nicely and can be configured to fire automatically with every migration. I added this at this point to make the way forward a bit more painless.