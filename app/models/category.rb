class Category < ActiveRecord::Base
  has_many :articles

  def name
    I18n.t("categories.#{self.sysname}")
  end
end
