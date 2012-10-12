# Biffbot

Ruby gem to connect to diffbot's article api

## Installation

Add this line to your application's Gemfile:

    gem 'biffbot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install biffbot

## Usage

Usage example:

	biff = Biffbot::Base.new("your developer token")
	article = biff.parse("the url you want to parse",options)

You can use the options hash to set the following: tags, stats, dontStripAds, comments, summary, html

example:

	options = Hash.new
	options[:tags] = true
	options[:stats] = true
	biff = Biffbot::Base.new("your developer token")
	article = biff.parse("the url you want to parse",options)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
