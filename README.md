# Biffbot
[![Build Status](https://travis-ci.org/tevren/biffbot.svg?branch=master)](https://travis-ci.org/tevren/biffbot)

Ruby gem to connect to diffbot's APIs

## Installation

Add this line to your application's Gemfile:

    gem 'biffbot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install biffbot

## Usage

Usage example:
OLD DEPCRECATED METHOD: 

    require 'biffbot'
    token = YOUR_DEVELOPER_TOKEN
	biff = Biffbot::Base.new(token)
	article = biff.parse("the url you want to parse",options)

NEW METHOD: 

    require 'biffbot'
    token = YOUR_DEVELOPER_TOKEN
    analyze = Biffbot::Analyze.new(token, url, {:type => 'article'})
    article = Biffbot::Article.new(@token,url,some_hash_of_options)


The available classes are: 
* Biffbot::Analyze
* Biffbot::Article
* Biffbot::Image
* Biffbot::Product
* Untested Classes (I don't have a paid account)

    * Biffbot::Bulk
    * Biffbot::Custom

## Testing

1. create a .env file in the following format:

        DIFFBOT_DEV_TOKEN=YOUR_DIFFBOT_TOKEN

2. run the tests via rake

        rake test

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
