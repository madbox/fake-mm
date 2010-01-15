class Category < ActiveRecord::Base
  has_many :articles

  named_scope :public, :conditions => {:public => true}

  def name
    I18n.t("categories.#{self.sysname}")
  end
end
