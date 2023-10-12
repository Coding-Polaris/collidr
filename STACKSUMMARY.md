# Collidr - Stack and tool summary

Ruby 3.2.2
Rails 7 - Web framework
PostgreSQL 14 - Relational database
Okta Auth0 - External authentication service
Redis - In-memory cacheing/DB service leveraged by Sidekiq

**Gems**

annotate\_models - allows one to display DB columns etc. as a commented table on models
https://github.com/ctran/annotate\_models

wisper - a lightweight pub-sub mixin well-suited to creating timeline items and avoiding coupled models
(preferred for ease of use and therefore speed over ActiveSupport::Notifications)
https://github.com/krisleech/wisper

Sidekiq - A background job queueing gem powered by Redis
https://github.com/sidekiq/sidekiq

Auth0 + dependencies

TESTING

rspec
https://github.com/dchelimsky/rspec

shoulda-matchers - quick, shorthand tests, best used with TDD
https://github.com/thoughtbot/shoulda-matchers

factory\_bot - create flexible, modular, reusable fixtures
https://github.com/thoughtbot/factory\_bot

faker - create randomized, fake data quickly for testing purposes
https://github.com/faker-ruby/faker

DEBUG

better\_errors/binding\_of\_caller - a debugging console that allows direct inspection of server-side execution values
https://github.com/BetterErrors/better\_errors

**Tools**

Sublime Text 3 w/ Vim plugin
Windows Subsystem for Linux (WSL2)
DrawSQL - online SQL to schema visualization tool
ChatGPT - With a hefty dose of my discretion, and with combing through all provided examples: To help explain new tools to me, handle foundational code or suggest/demonstrate patterns to use, or to help debug breaking tests or code.
