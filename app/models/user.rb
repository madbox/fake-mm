class User < ActiveRecord::Base
  acts_as_authentic

  has_many :articles
  has_many :comments, :through => :articles

  def name
    [lname, fname].join(' ')
  end
end
