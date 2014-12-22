require 'httparty'
require 'json'
require 'hashie'
require 'cgi'
module Biffbot
  class Bulk < Base
    include Hashie::Extensions::Coercion
    def initialize token
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

    def pause name
      endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}&pause=1"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end

    def unpause name
      endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}&pause=0"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end

    def restart name
      endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}&restart=1"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end

    def delete name
      endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}&delete=1"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end

    def retrieve_data jobName, _options = {}
      # TODO: add support for csv
      endpoint = "http://api.diffbot.com/v3/bulk/download/#{@token}-#{jobName}_data.json"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end

    def view name
      endpoint = "http://api.diffbot.com/v3/bulk/?token=#{@token}&name=#{name}"
      JSON.parse(HTTParty.get(endpoint).body).each_pair do |key, value|
        self[key] = value
      end
    end
  end
end
