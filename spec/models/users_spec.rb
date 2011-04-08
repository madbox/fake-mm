require 'spec_helper'

describe User do
  fixtures :all

  describe "Fixtures" do
    it "should create admin with role admin" do
      users( :admin ).roles.should be_eql( [roles( :admin )] )
    end

    it "should create newsmaker with roles customer & newsmaker" do
      users( :newsmaker ).roles.should be_eql( [roles( :customer ), roles( :newsmaker )] )
    end

    it "should create guest without roles" do
      users( :guest ).roles.should have( 0 ).roles
    end
  end
end
