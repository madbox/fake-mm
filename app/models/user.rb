class User < ActiveRecord::Base
  acts_as_authentic
  using_access_control

  has_many :articles
  has_many :comments, :through => :articles
  has_and_belongs_to_many :roles, :join_table => "assigments"

  has_attached_file :avatar, :styles => {:normal => "300x200"}, :default_style => :normal

  def name
    if (str = [lname, fname].join(' ')).blank?
      I18n.t('misc.unknown_user')
    else
      str
    end
  end

  def role_symbols
    # TODO: нориальные роли надо сделать
    @role_symbols ||= ( roles.map{|r|r.sysname.to_sym} << :guest )
  end
end
