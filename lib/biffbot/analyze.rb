require 'biffbot/base'
module Biffbot
  class Analyze < Base
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'analyze', url, options)
    end
  end
end
