require 'spec_helper'
# more tests to come... 
describe Biffbot do
	before :each do 
		@token = "YOUR TOKEN HERE"
		@biffbot = Biffbot::Base.new(@token)		
	end

	describe "#get_huffinton_post_article" do
		it "not nil" do
		  @biffbot.parse("http://www.huffingtonpost.ca/2012/10/11/amanda-todd-teen-bullying-suicide-youtube_n_1959668.html").size.should_not be_nil
		end
	end
end