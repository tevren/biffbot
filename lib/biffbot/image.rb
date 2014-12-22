require 'biffbot/base'
module Biffbot
  class Image < Base
    # a new instance of Biffbot::Image
    #
    # @param url [String] The url of an page with images you want to analyze
    # @param options [Hash] An hash of options
    # @param token [String] Override Biffbot.token with another token
    # @return [Hash]
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'image', url, options)
    end
  end
end
