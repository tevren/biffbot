# Biffbot 
[![Build Status](https://travis-ci.org/tevren/biffbot.svg?branch=master)](https://travis-ci.org/tevren/biffbot) [![Gem Version](https://badge.fury.io/rb/biffbot.svg)](http://badge.fury.io/rb/biffbot) [![Code Climate](https://codeclimate.com/github/tevren/biffbot/badges/gpa.svg)](https://codeclimate.com/github/tevren/biffbot) [![Test Coverage](https://codeclimate.com/github/tevren/biffbot/badges/coverage.svg)](https://codeclimate.com/github/tevren/biffbot) [![Inline docs](http://inch-ci.org/github/tevren/biffbot.svg?branch=master&style=flat)](http://inch-ci.org/github/tevren/biffbot)

Ruby gem to connect to diffbot's APIs

## Installation

Add this line to your application's Gemfile:

    gem 'biffbot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install biffbot

## Usage

### Usage example:

    require 'biffbot'
    Biffbot.token = YOUR_DEVELOPER_TOKEN
    analyze = Biffbot::Analyze.new(url, {:type => 'article'})
    article = Biffbot::Article.new(url,some_hash_of_options)

#### Available classes: 
* Biffbot::Analyze
* Biffbot::Article
* Biffbot::Image
* Biffbot::Product
* Untested Classes (I don't have a paid account)

    * Biffbot::Bulk
    * Biffbot::Custom

## To do

* Add support for Diffbot Crawlbot API
* Add support for Diffbot Search API
* Add support for Diffbot beta APIs (video/discussion)

## Testing

1. Create a .env file in the following format:

        DIFFBOT_DEV_TOKEN=YOUR_DIFFBOT_TOKEN

2. Run the tests via rake

        rake test

3. Style matters, check your rubocop output. 

## Updating

- Create a branch off of master and make your changes.
 - eg: ```git checkout -b fix_bulk```
- Create a pull request for review.
- Once reviewed and merged, pull the latest master and update version.rb. The major, minor and patch versions match the version of Biffbot itself and should not be changed except for updates. Update the number at the end.
- Commit the changes and push
 - ```git commit -m "Release vX.X.X.descriptive.name" && git push origin master```
- Tag the release and push, git tag vX.X.X.descriptive.name && git push --tags.
 - eg: v1.2.13.fix.bulk
- Build the gem
 - ```gem build biffbot.gemspec```.
- Push the gem to Gemfury 
 - ```fury push biffbot-1.2.13.fix.pre.bulk.gem --as=doximity```.
