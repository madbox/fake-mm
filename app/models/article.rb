class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates_presence_of :user
  has_attached_file :image, :styles => {:normal => "408x300>"}, :default_style => :normal
end
