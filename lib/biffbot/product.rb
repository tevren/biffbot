require 'biffbot/base'
module Biffbot
  class Product < Base
    def initialize token, url, options = {}
      @token = token
      parse(@token, 'product', url, options)
    end
  end
end
