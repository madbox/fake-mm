class Role < ActiveRecord::Base
#  has_many :assignments
#  has_many :users, :through => :assignments
  has_and_belongs_to_many :users, :join_table => "assigments"


  def name
    I18n.t("roles.#{self.sysname}")
  end
end
