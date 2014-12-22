require 'spec_helper'

# currently tests v2 article api
describe Biffbot::Article do
  before :each do
    url = 'http://www.huffingtonpost.ca/2012/10/11/amanda-todd-teen-bullying-suicide-youtube_n_1959668.html'
    Biffbot.token = ENV['DIFFBOT_DEV_TOKEN']
    @article = Biffbot::Article.new(url)
  end

  describe 'Biffbot::Article.parse' do
    it 'should have a type of article' do
      @article['type'].should include('article')
    end

    it 'should have an url' do
      @article['url'].should_not be_nil
      @article['url'].should be_a_kind_of(String)
      @article['url'].should include('http')
    end

    it 'should have the default fields for an article' do
      %w(icon title text html date author images videos).each do |field|
        @article[field].should_not be_nil
      end
    end
  end
end
