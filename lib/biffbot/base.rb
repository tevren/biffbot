require 'httparty'
require 'json'
require 'hashie'
require 'cgi'
module Biffbot
  class Base < Hash
    include Hashie::Extensions::Coercion
    # a new instance of Biffbot::Base
    #
    # @param token [String]  Override Biffbot.token with another token
    # @param type [String] pass the class type you're working with
    # @param url [String] The url of the page you're working with
    # @param options [Hash] An hash of options
    # @return [Hash]
    def parse token = Biffbot.token, type = 'article', url = '', options = {}
      diffbot_url = generate_url(url, token, type, options[:version])
      url = URI.escape(parse_options(options, diffbot_url))
      JSON.parse(HTTParty.get(url).body).each_pair do |key, value|
        self[key] = value
      end
    end

    # generate an url consisting of your api key and the endpoint you'd like to use
    #
    # @param url [String] The url to pass to diffbot
    # @param token [String] Diffbot API token
    # @param type [String] API to use
    # @return [String] a formatted url with your api key, endpoint and input url
    def generate_url url, token, type, version
      case type
      when 'analyze'
        return_url = "http://api.diffbot.com/v3/#{type}?token=#{token}&url=#{url}"
      when 'custom'
        return_url = "http://api.diffbot.com/v3/#{options[:api_name]}?token=#{token}&url=#{url}"
      when 'article', 'image', 'product'
        return_url = "http://api.diffbot.com/v2/#{type}?token=#{token}&url=#{url}"
        return_url = "http://api.diffbot.com/#{version}/#{type}?token=#{token}&url=#{url}" if version == 'v2' || version == 'v3'
      end
      return_url
    end

    # add the options hash to your input url
    #
    # @param options [Hash] An hash of options
    # @param request [String] The url to append options to
    # @return [String] a formatted url with options merged into the input url
    def parse_options options = {}, request = ''
      options.each do |opt, value|
        case value
        when NilClass
          request += "&#{opt}"
        when Array
          request += "&#{opt}=#{value.join(',')}"
        else
          request += "&#{opt}=#{value}"
        end
      end
      request
    end
  end
end
