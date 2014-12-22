require 'spec_helper'

# currently tests v2 product api
describe Biffbot::Product do
  before :each do
    url = 'http://www.amazon.com/Google-Chromecast-Streaming-Media-Player/dp/B00DR0PDNE/'
    Biffbot.token = ENV['DIFFBOT_DEV_TOKEN']
    @product = Biffbot::Product.new(url)
  end

  describe 'Biffbot::Product.parse' do
    it 'should have a type of article' do
      @product['type'].should include('product')
    end

    it 'should have an url' do
      @product['url'].should_not be_nil
      @product['url'].should be_a_kind_of(String)
      @product['url'].should include('http')
    end

    it 'should have an offer price' do
      @product['offerPrice'].should_not be_nil
      @product['offerPrice'].should be_a_kind_of(String)
    end

    it 'should have the default fields for an image' do
      %w(title text leafPage offerPrice images type products url).each do |field|
        @product[field].should_not be_nil
      end
    end
  end
end
