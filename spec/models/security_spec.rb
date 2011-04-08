require 'spec_helper'

describe User do
  fixtures :all

  describe "Admin" do
  end
  
  describe "Guest" do
    it "should not be able to create news" do
      lambda { 
        with_user( users( :guest ) ) do
          Article.create( :title => 'ttt',
                          :content => 'qweqwe',
                          :sysname => 'test_art',
                          :category => categories( :system ),
                          :user => users( :guest ) )
        end
      }.should raise_error( Authorization::NotAuthorized )
    end
  end
  
  describe "Newsmaker" do
    it "should be able to create news" do
      lambda { 
        with_user( users( :newsmaker ) ) do
          a = Article.new( :title => 'ttt',
                          :content => 'qweqwe',
                          :sysname => 'test_art',
                          :category => categories( :news ),
                          :user => users( :newsmaker ) )
          a.save!
        end
      }.should_not raise_error( Authorization::NotAuthorized )
    end

    it "should not be able to create not news" do
      lambda { 
        with_user( users( :newsmaker ) ) do
          a = Article.new( :title => 'ttt',
                          :content => 'qweqwe',
                          :sysname => 'test_art',
                          :category => categories( :system ),
                          :user => users( :newsmaker ) )
          a.save!
        end
      }.should raise_error( Authorization::AttributeAuthorizationError )
    end
  end
end
