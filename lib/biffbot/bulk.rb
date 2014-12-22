require 'httparty'
require 'json'
require 'hashie'
require 'cgi'
module Biffbot
  class Bulk < Base
    include Hashie::Extensions::Coercion
    def initialize token = Biffbot.token
      @token = token
    end

    def create_job name, api_type, urls = [], options = {}
      api_url = "http://api.diffbot.com/v2/#{api_type}"
      api_url = "http://api.diffbot.com/#{options[:version]}/#{api_type}" if options[:version] == 'v2' || options[:version] == 'v3'
      api_url = parse_options(options, api_url)
      endpoint = 'http://api.diffbot.com/v3/bulk'
      post_body = generate_post_body(name, api_url, urls, options)
      JSON.parse(HTTParty.post(endpoint, body: post_body.to_json, headers: {'Content-Type' => 'application/json'}).body).each_pair do |k, v|
        self[k] = v
      end
    end

    def generate_post_body name, api_url, urls = [], options = {}
      post_body = {token: @token, name: name, apiUrl: api_url, urls: urls}
      options.each do |key, value|
        next unless %w(notifyEmail maxRounds notifyWebHook pageProcessPattern).include?(key.to_s)
        post_body[key] = value
      end
      post_body
    end

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

    def retrieve_data jobName, _options = {}
      # TODO: add support for csv
      endpoint = "http://api.diffbot.com/v3/bulk/download/#{@token}-#{jobName}_data.json"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end
  end
end
