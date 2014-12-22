require 'biffbot/base'
module Biffbot
  class Image < Base
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'image', url, options)
    end
  end
end
