require 'biffbot/base'
module Biffbot
  class Image < Base
    def initialize token, url, options = {}
      @token = token
      parse(@token, 'image', url, options)
    end
  end
end
