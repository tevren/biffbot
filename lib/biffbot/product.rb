require 'biffbot/base'
module Biffbot
  class Product < Base
    def initialize url, options = {}, token = Biffbot.token
      parse(token, 'product', url, options)
    end
  end
end
