require 'spec_helper'

describe Article do
  fixtures :all


  it "should be creatable" do
    without_access_control do
      lambda { 
        Article.create( :title => 'ttt',
                        :content => 'qweqwe',
                        :sysname => 'test_art',
                        :category => categories( :system ),
                        :user => users( :admin ) )
      }.should_not raise_error
    end
  end

  it "should be publishable" do
    without_access_control do
      articles( :unpublished ).publish.should be_true
    end
  end

  it "should not be publishable if it is a draft" do
    without_access_control do
      articles( :unpublishable ).publish.should be_false
    end
  end
end
