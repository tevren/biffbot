require 'biffbot/base'
module Biffbot
  class Analyze < Base
    # a new instance of Biffbot::Analyze
    #
    # @param url [String] The url to analyze
    # @param options [Hash] An hash of options
    # @param token [String] Override Biffbot.token with another token
    # @return [Hash]
    # @example
    #   Biffbot::Analyze('http://www.nytimes.com', mode: 'article', timeout: 60) => {SOME_HASH}
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'analyze', url, options)
    end
  end
end
