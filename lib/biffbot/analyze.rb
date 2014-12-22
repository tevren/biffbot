require 'biffbot/base'
module Biffbot
  class Analyze < Base
    def initialize token, url, options = {}
      @token = token
      parse(@token, 'analyze', url, options)
    end
  end
end
