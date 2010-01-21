class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :style
  has_many :comments
  has_many :tags
  
  validates_presence_of :user
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :sysname

  validates_presence_of :category
  
  validates_format_of :importance, :with => /\d+/

  has_attached_file :imagebv, :styles => {:normal => "408x611"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagebh, :styles => {:normal => "616x411"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagemv, :styles => {:normal => "96x96"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagemh, :styles => {:normal => "200x300"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagemm, :styles => {:normal => "408x272"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"

  validates_presence_of :imagebv
  validates_presence_of :imagebh
  validates_presence_of :imagemv
  validates_presence_of :imagemh
  validates_presence_of :imagemm

  named_scope :news, :joins => :category, :conditions => ['categories.sysname = ?', 'news']
  named_scope :published, :conditions => ['publish_date != ?', nil]
  named_scope :drafts, :conditions => ['publish_date = ?', nil]

  named_scope :most_important, :order => 'importance DESC'
end
