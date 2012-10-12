require 'httparty'
module Biffbot
	class Base
		def initialize(token) 
			@token = token
		end
		def parse(url,options={})
			@url = url
			output = Hash.new
			request = "http://www.diffbot.com/api/article?token=#{@token}&url=#{@url}"
			raise request.to_s
			options.each_pair do |key,value|
				if key.match(/html|dontStripAds|tags|comments|summary|stats/) && value == true
					request = request + "&#{key}"
				end
			end
			puts request
			response = HTTParty.get(request)
			response.parsed_response.each_pair do |key,value|
				output[key.to_sym] = value
			end
			return output
		end
	end
end
