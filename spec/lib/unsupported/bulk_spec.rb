require 'spec_helper'

# currently tests v2 bulk api
describe Biffbot::Bulk do
  before :each do
    token = ENV['DIFFBOT_DEV_TOKEN']
    @bulk = Biffbot::Bulk.new(token)
  end

  it 'should create a bulk job' do
    urls = ['http://www.washingtonpost.com/blogs/wonkblog/wp/2014/12/18/100000-prisoners-are-in-for-low-level-drug-offenses-obama-just-gave-relief-to-8/',
            'http://www.wired.com/2013/01/4th-amendment-chest-trial/']
    @bulk.create_job('test', 'article', urls).should_not be_nil
  end

  it 'should view the bulk job' do
    @bulk.view('test').should_not be_nil
  end

  it 'should delete the bulk job' do
    @bulk.delete('test').should_not be_nil
  end
end
