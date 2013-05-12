require 'httparty'
require 'json'

module Biffbot
	class Base
		def initialize(token) 
			@token = token
		end
		def parse(url,options={})
			@url = url
			output = Hash.new
			request = "http://www.diffbot.com/api/article?token=#{@token}&url=#{@url}"
			options.each_pair do |key,value|
				if key.match(/html|dontStripAds|tags|comments|summary|stats/) && value == true
					request = request + "&#{key}"
				end
			end
			response = HTTParty.get(request)
			response.parsed_response.each_pair do |key,value|
				output[key.to_sym] = value
			end
			return output
		end
		def batch(urls=[],options={})
			output = []
			request = "http://www.diffbot.com/api/batch"
      		batch = urls.map do |url|
    			{ :method => "GET", :relative_url => "/api/article?token=#{@token}&url=#{url}" }
      		end
     		options = { :body => {:token => @token, :batch => batch.to_json }, :basic_auth => @auth }
			response = HTTParty.post(request, options)
      
			JSON.parse(response.parsed_response).each do |response_dict|
        		puts response_dict.inspect
				output << JSON.parse(response_dict["body"])
			end
			return output
    	end
	end
end
