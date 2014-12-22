require 'spec_helper'

# more tests to come...
describe Biffbot::Analyze do
  before :each do
    url = 'http://www.huffingtonpost.ca/2012/10/11/amanda-todd-teen-bullying-suicide-youtube_n_1959668.html'
    Biffbot.token = ENV['DIFFBOT_DEV_TOKEN']
    @article = Biffbot::Analyze.new(url, type: 'article')
  end

  describe 'analyze an article' do
    it 'should have a type of article' do
      @article['type'].should include('article')
    end

    it 'should have an human language field' do
      @article['humanLanguage'].should_not be_nil
      @article['humanLanguage'].should be_a_kind_of(String)
    end

    it 'should have an url' do
      @article['objects'].first['pageUrl'].should_not be_nil
      @article['objects'].first['pageUrl'].should be_a_kind_of(String)
      @article['objects'].first['pageUrl'].should include('http')
    end

    it 'should have some text' do
      @article['objects'].first['text'].should_not be_nil
      @article['objects'].first['text'].should be_a_kind_of(String)
    end
  end
end
