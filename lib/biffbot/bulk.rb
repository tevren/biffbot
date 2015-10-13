require 'httparty'
require 'json'
require 'hashie'
require 'cgi'
module Biffbot
  class Bulk < Base
    include Hashie::Extensions::Coercion
    # a new instance of Biffbot::Bulk
    #
    # @param token [String] Override Biffbot.token with another token
    def initialize token = Biffbot.token
      @token = token
    end

    # create a bulk job
    #
    # @param name [String]  Desired name for bulk job
    # @param api_type [String] Desired API to use for urls. This accepts options as query params to the regular article api.
    # @param urls [Array] An array of input urls to pass to bulk job
    # @param options [Hash] An hash of options
    # @return [Hash]
    def create_job name, api_type, urls = [], options = {}
      api_url = "http://api.diffbot.com/v2/#{api_type}"
      api_url = "http://api.diffbot.com/#{options[:version]}/#{api_type}" if options[:version] == 'v2' || options[:version] == 'v3'
      api_url = parse_options(options, api_url)
      endpoint = 'http://api.diffbot.com/v3/bulk'
      post_body = generate_post_body(name, api_url, urls, options)

      www_form_encoded_body = URI.encode_www_form(post_body)

      JSON.parse(HTTParty.post(endpoint, body: www_form_encoded_body, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}).body).each_pair do |k, v|
        self[k] = v
      end
    end

    # generate the POST body required for bulk job creation
    #
    # @param name [String]  Desired name for bulk job
    # @param api_url [String] Desired API url to use for urls
    # @param urls [Array] An array of input urls to pass to bulk job
    # @param options [Hash] An hash of options
    # @return [Hash]
    def generate_post_body name, api_url, urls = [], options = {}
      post_body = {token: @token, name: name, apiUrl: api_url, urls: urls}
      options.each do |key, value|
        valid_api_arguments = %w(token name urls apiUrl notifyEmail notifyWebHook repeat maxRounds pageProcessPattern)
        next unless valid_api_arguments.include?(key.to_s)
        post_body[key] = value
      end
      post_body
    end

    # Using define_method to create methods for each action rather than defining each method seperately.
    %w(pause unpause restart delete view).each do |method_name|
      define_method method_name do |name|
        case method_name
        when 'pause', 'restart', 'delete'
          endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}&#{method_name}=1"
        when 'unpause'
          endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}&#{method_name}=0"
        when 'view'
          endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}"
        end
        JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
          self[key] = value
        end
      end
    end

    # retrieve data per given jobName
    #
    # @param jobName [String] Name of bulk job
    # @param _options [Hash] An hash of options
    # @return [Hash]
    def retrieve_data jobName, _options = {}
      # TODO: add support for csv
      endpoint = "http://api.diffbot.com/v3/bulk/download/#{@token}-#{jobName}_data.json"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end
  end
end
