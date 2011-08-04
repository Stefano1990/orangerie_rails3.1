require 'spec_helper'

describe Page do
  before(:each) do
    @attr = { :title => "The foobar title for this page.", 
              :content  => "This is a foobar content", 
              :comments => true,
              :lang => "en"
            }
  end
  
  it "should have a title" do
    @page = Page.create!(@attr)
    @page.title should_not be_blank
  end
  
  it "should have some content" do
  end
  
  it "should have a language" do
  end
  
  it "should respond to comments" do
  end
  
  it "should create a new instance given valid attributes" do
    Page.create!(@attr)
  end
end
