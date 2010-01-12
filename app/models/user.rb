class User < ActiveRecord::Base
  acts_as_authentic
  using_access_control

  has_many :articles
  has_many :comments, :through => :articles

  has_attached_file :avatar, :styles => {:normal => "300x200"}, :default_style => :normal

  def name
    if (str = [lname, fname].join(' ')).blank?
      I18n.t('misc.unknown_user')
    else
      str
    end
  end

  def role_symbols
    @role_symbols ||= [:guest, :customer]
  end
end
