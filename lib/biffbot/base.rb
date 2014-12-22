require 'httparty'
require 'json'
require 'hashie'
require 'cgi'
module Biffbot
  class Base < Hash
    include Hashie::Extensions::Coercion
    def parse token = Biffbot.token, type = 'article', url = '', options = {}
      url = parse_options(options, generate_url(CGI.escape(url), token, type, options[:version]))
      JSON.parse(HTTParty.get(url).body).each_pair do |key, value|
        self[key] = value
      end
    end

    def generate_url url, token, type, version
      case type
      when 'analyze'
        url = "http://api.diffbot.com/v3/#{type}?token=#{token}&url=#{url}"
      when 'custom'
        url = "http://api.diffbot.com/v3/#{options[:api_name]}?token=#{token}&url=#{url}"
      when 'article', 'image', 'product'
        url = "http://api.diffbot.com/v2/#{type}?token=#{token}&url=#{url}"
        url = "http://api.diffbot.com/#{version}/#{type}?token=#{token}&url=#{url}" if version == 'v2' || version == 'v3'
      end
      url
    end

    def parse_options options = {}, request = ''
      options.each do |opt, value|
        case opt
        when :timeout, :paging, :mode
          request += "&#{opt}=#{value}"
        when :callback, :stats
          request += "&#{opt}"
        when :fields
          request += "&#{opt}=" + value.join(',') if value.is_a?(Array)
        end
      end
      request
    end
  end
end
