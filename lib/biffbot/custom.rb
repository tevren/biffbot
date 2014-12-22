require 'biffbot/base'
module Biffbot
  class Custom < Base
    def initialize url, api_name, options = {}, token = Biffbot.token
      options[:api_name] = api_name
      parse(token, 'custom', url, options)
    end
  end
end
