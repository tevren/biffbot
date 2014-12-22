require 'biffbot/base'
module Biffbot
  class Custom < Base
    def initialize token, url, api_name, options = {}
      @token = token
      options[:api_name] = api_name
      parse(@token, 'custom', url, options)
    end
  end
end
