class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :style
  has_many :comments
  has_many :tags
  
  validates_presence_of :user
  has_attached_file :imagebv, :styles => {:normal => "408x611"}, :default_style => :normal
  has_attached_file :imagebh, :styles => {:normal => "500x300"}, :default_style => :normal
  has_attached_file :imagemv, :styles => {:normal => "96x96"}, :default_style => :normal
  has_attached_file :imagemh, :styles => {:normal => "200x300"}, :default_style => :normal

  named_scope :news, :joins => :category, :conditions => ['categories.sysname = ?', 'news']
  
end
