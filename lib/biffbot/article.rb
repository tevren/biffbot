require 'biffbot/base'
module Biffbot
  class Article < Base
    # a new instance of Biffbot::Article
    #
    # @param url [String] The url of an article to grab
    # @param options [Hash] An hash of options
    # @param token [String] Override Biffbot.token with another token
    # @return [Hash]
    # @example
    #   Biffbot::Article('http://www.nytimes.com', timeout: 60) => {SOME_HASH}
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'article', url, options)
    end
  end
end
