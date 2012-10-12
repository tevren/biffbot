require "biffbot/version"
require "biffbot/base"
module Biffbot
  # Your code goes here...
  def self.reset!
    @token = nil
  end
  class << self
	#Your Diffbot API token.
    attr_accessor :token
  end
end
