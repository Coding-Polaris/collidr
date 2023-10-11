A much more structured roadmap were I to build the app a second time:

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

Create migrations for all tables

Export to .sql file with this in development.rb

    config.active_record.schema_format = :sql

Put on DrawSQL and create pretty graphic, set constraints, review and add migrations for any missing info, and add to repo.

Write failing model specs for each added table that include:
	- Basic data validations
	- Planned associations in both directions

Write factories and model code to pass tests

Write failing model specs for planned business logic for each model