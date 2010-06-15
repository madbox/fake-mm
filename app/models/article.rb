# -*- coding: utf-8 -*-
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
  validates_uniqueness_of :sysname
  validates_format_of :sysname, :with => /^[a-zA-Z\d_]+$/

  validates_presence_of :category
  
  validates_format_of :importance, :with => /\d+/

  has_attached_file :imagebv, :styles => {:normal => "408x611"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagebh, :styles => {:normal => "616x411"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagemv, :styles => {:normal => "96x96"},   :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagemh, :styles => {:normal => "200x300"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"
  has_attached_file :imagemm, :styles => {:normal => "408x272"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"

  # Все картинки должны быть, если мы хотим вывести из черновиков
  validates_attachment_presence :imagebv, :if => lambda { |a| !a.draft && !a.published }
  validates_attachment_presence :imagebh, :if => lambda { |a| !a.draft && !a.published }
  validates_attachment_presence :imagemv, :if => lambda { |a| !a.draft && !a.published }
  validates_attachment_presence :imagemh, :if => lambda { |a| !a.draft && !a.published }
  validates_attachment_presence :imagemm, :if => lambda { |a| !a.draft && !a.published }

  named_scope :news, :joins => :category, :conditions => ["categories.sysname = ?", 'news']
  named_scope :published, :conditions => {:published => true}
  named_scope :drafts, :conditions => {:draft => true} 

  named_scope :most_important, :order => 'importance DESC'

  named_scope :public_category_last, :include => :category, :conditions => ["categories.public = ?", true]

  def unpublish
    self.published = false
    self.publish_date = nil
    self.save
  end

  def publish
    self.published = true
    self.publish_date = Time.now
    self.save
  end

  def make_draft
    self.published = false
    self.publish_date = nil
    self.draft = true
    self.save
  end

  def undraft
    self.draft = false
    self.save
  end

  def to_param
    sysname || id
  end
end
