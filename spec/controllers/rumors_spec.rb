require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Rumors, "index action" do
  before(:each) do
    dispatch_to(Rumors, :index)
  end
end