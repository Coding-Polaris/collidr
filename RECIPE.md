A much more structured roadmap, for if I were to build the app a second time

(or the first time, for some features)

rails new collidr

Make matching repo on GitHub and push initial commit

Add gems:
	- RSpec
	- FactoryBot
	- Faker
	- Shoulda_matchers
	- Annotate
	- Wisper
	- Better_errors + binding_of_caller
	- Auth0/dependencies

FactoryBot config:

	create ./spec/support/factory_bot.rb, put this in it

	RSpec.configure do |config|
	  config.include FactoryBot::Syntax::Methods
	end

development.rb for \_factory suffix:

	config.generators do |g|
	    # append factory_bot generatored files with _factory
	    g.factory_bot suffix: "factory"
	end

Create migrations for all planned tables

Export to .sql file by putting this in development.rb

    config.active_record.schema_format = :sql

Put on DrawSQL
	- Set DB constraints
	- Create pretty graphic/visual schema
	- Review schema
	- Add migrations for any missing info

Comment out previous config statement

Write failing model specs for each added table that include:
	- Basic data validations
	- Planned associations in both directions

Write factories and model code to pass tests <- **I am here**

Write failing model specs for planned business logic for each model:
	User.create_rating
	User.update_rating_from_average_ratings
	User.create_comment
	User.create_post
	ActivityItem logic working with GitHub events
then fix

Write failing basic auth specs and associated controller action tests,
then fix

Write failing controller/API action tests,
then fix

Write failing integration tests between API actions (post -> data change on back end -> receive different timeline),
then fix
