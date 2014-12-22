require 'biffbot/base'
module Biffbot
  class Article < Base
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'article', url, options)
    end
  end
end
