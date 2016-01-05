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
      @results = parse(token, 'article', url, options)
    end

    def parse token = Biffbot.token, type = 'article', url = '', options = {}
      diffbot_query_params[:url] = url
      diffbot_query_params[:token] = token
      diffbot_query_params[:fields] ||= %w(icon title text html date author images videos)

      options[:version] ||= 'v3'

      super(token, type, url, options)
    end
  end
end
