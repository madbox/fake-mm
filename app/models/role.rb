class Role < ActiveRecord::Base
#  acts_as_authentic
#  using_access_control

  has_and_belongs_to_many :users, :join_table => "assigments", :uniq => true

  def name
    I18n.t("roles.#{self.sysname}")
  end
end
