require 'biffbot/base'
module Biffbot
  class Article < Base
    def initialize token, url, options = {}
      @token = token
      parse(@token, 'article', url, options)
    end
  end
end
