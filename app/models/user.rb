class User < ActiveRecord::Base
  acts_as_authentic

  has_many :articles
  has_many :comments, :through => :articles

  def name
    if (str = [lname, fname].join(' ')).blank?
      I18n.t('misc.unknown_user')
    else
      str
    end
  end
end
