require 'httparty'
require 'json'
require 'hashie'
require 'cgi'
require 'addressable/uri'

module Biffbot
  class Base < Hash
    include Hashie::Extensions::Coercion

    def diffbot_url
      @diffbot_url ||= Addressable::URI.new(host: 'api.diffbot.com', scheme: 'https')
    end

    def diffbot_query_params
      @diffbot_query_params ||= Hash.new
    end

    # a new instance of Biffbot::Base
    #
    # @param token [String]  Override Biffbot.token with another token
    # @param type [String] pass the class type you're working with
    # @param url [String] The url of the page you're working with
    # @param options [Hash] An hash of options
    # @return [Hash]
    def parse token = Biffbot.token, type = 'article', url = '', options = {}
      options[:version] ||= 'v3'
      http_options = options.delete(:http_options) || {}

      diffbot_query_params[:token] = token

      generate_url(url, token, type, options[:version])
      parse_options(options)

      response = HTTParty.get(diffbot_url, http_options)

      return {} if response.nil?

      JSON.parse(response.body).each_pair do |key, value|
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
      diffbot_query_params[:token] = token
      diffbot_query_params[:url] = url

      if type == 'custom'
        diffbot_url.path = "v3/#{options[:api_name]}"
      else
        diffbot_url.path = "#{version}/#{type}"
      end

    end

    # add the options hash to your input url
    #
    # @param options [Hash] An hash of options
    # @param request [String] The url to append options to
    # @return [String] a formatted url with options merged into the input url
    def parse_options options = {}, request = ''
      uri = request.present? ? Addressable::URI.parse(request) : diffbot_url

      options.each do |opt, value|
        if opt.is_a?(Array)
          diffbot_query_params[opt.to_sym] = diffbot_query_params[opt.to_sym].push(value).flatten.uniq
        else
          diffbot_query_params[opt.to_sym] = value
        end
      end

      diffbot_query_params.each do |key, value|
        diffbot_query_params[key] = value.join(',') if value.is_a?(Array)
      end

      uri.query_values = diffbot_query_params

      uri
    end
  end
end
