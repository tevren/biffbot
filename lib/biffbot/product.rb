require 'biffbot/base'
module Biffbot
  class Product < Base
    # a new instance of Biffbot::Product
    #
    # @param url [String] The url of an page with products you want to analyze
    # @param options [Hash] An hash of options
    # @param token [String] Override Biffbot.token with another token
    # @return [Hash]
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'product', url, options)
    end
  end
end
