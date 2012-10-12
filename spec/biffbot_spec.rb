require 'spec_helper'
# more tests to come... 
describe Biffbot do
	before :each do 
		@biffbot = Biffbot::Base.new
		@token = "YOUR TOKEN HERE"
	end

	describe "#get_huffinton_post_article" do
		it "not nil" do
		  @biffbot.parse(@token,"http://www.huffingtonpost.ca/2012/10/11/amanda-todd-teen-bullying-suicide-youtube_n_1959668.html").size.should_not be_nil
		end
	end
end