require 'biffbot/base'
module Biffbot
  class Custom < Base
    # a new instance of Biffbot::Custom
    #
    # @param url [String] The url to pass to your custom api
    # @param api_name [String] The name of your custom api
    # @param options [Hash] An hash of options
    # @param token [String] Override Biffbot.token with another token
    # @return [Hash]
    # @example
    #   Biffbot::Custom('http://www.nytimes.com', 'my_cool_nytimes_api', timeout: 60) => {SOME_HASH}
    def initialize url, api_name, options = {}, token = Biffbot.token
      options[:api_name] = api_name
      parse(token, 'custom', url, options)
    end
  end
end
