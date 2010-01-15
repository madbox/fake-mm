class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments

  def name
    I18n.t("roles.#{self.sysname}")
  end
end
