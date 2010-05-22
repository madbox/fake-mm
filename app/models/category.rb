class Category < ActiveRecord::Base
  has_many :articles
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :sysname
  validates_format_of :sysname, :with => /[a-z_]/

  has_attached_file :imagemh, :styles => {:normal => "200x300"}, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"

  named_scope :public, :conditions => {:public => true}

  def author
    self.user || (self.custom_author.blank? ? nil : self.custom_author) || I18n.t('misc.author_unknown')
  end
end
