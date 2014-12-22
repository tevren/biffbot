require 'spec_helper'

# currently tests v2 image api
describe Biffbot::Image do
  before :each do
    token = ENV['DIFFBOT_DEV_TOKEN']
    url = 'http://www.huffingtonpost.ca/2012/10/11/amanda-todd-teen-bullying-suicide-youtube_n_1959668.html'
    @image = Biffbot::Image.new(token, url)
  end

  describe 'Biffbot::Image.parse' do
    it 'should have a type of article' do
      @image['type'].should include('image')
    end

    it 'should have an url' do
      @image['url'].should_not be_nil
      @image['url'].should be_a_kind_of(String)
      @image['url'].should include('http')
    end

    it 'should have the default fields for an image' do
      %w(type title images url).each do |field|
        @image[field].should_not be_nil
      end
    end
  end
end
