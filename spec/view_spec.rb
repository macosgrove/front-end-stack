require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Home' do
  it "displays the README" do
    get "/"
    expect(last_response.body).to include("Front-End Stack")
  end
end