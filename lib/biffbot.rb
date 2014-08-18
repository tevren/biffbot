require "biffbot/version"
require "biffbot/analyze"
require "biffbot/article"
require "biffbot/base"
require "biffbot/batch"
require "biffbot/bulk"
require "biffbot/crawl"
require "biffbot/custom"
require "biffbot/frontpage"
require "biffbot/image"
require "biffbot/product"

module Biffbot
  def self.reset!
    @token = nil
  end
  class << self
	#Your Diffbot API token.
  end
end
