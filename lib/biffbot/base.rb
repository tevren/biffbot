include 'httparty'
module Biffbot
	class Base << self
		def parse(token,url,options={})
			@token = token
			@url = url
			output = Hash.new
			request = "http://www.diffbot.com/api/article?token=#{@token}&url=#{@token}"
			options.each_pair do |key,value|
				if key.match(/html|dontStripAds|tags|comments|summary|stats/) && value == true
					request = request + "&#{@key}"
				end
			end
			response = HTTParty.get(request)
			response.parsed_response.each_pair do |key,value|
				output[key.to_sym] = value
			end
			return output
		end
	end
end
