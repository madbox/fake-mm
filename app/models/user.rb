# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  acts_as_authentic
#  using_access_control

  has_many :articles
  has_many :categories
  has_many :comments
  has_and_belongs_to_many :roles, :join_table => "assigments", :uniq => true

  has_attached_file :avatar, :styles => {:normal => "200x300", :small => "96x96#" }, :default_style => :normal, :default_url => "/images/missing_:class_:attachment_:style.jpg"

  def has_role? role_name_or_symbol
    roles.map(&:sysname).include? role_name_or_symbol.to_s
  end

  def name
    if (str = [lname, fname].join(' ')).blank?
      I18n.t('misc.unknown_user')
    else
      str
    end
  end

  def role_symbols
    # TODO: реальные роли надо сделать
    @role_symbols ||= ( roles.map{|r|r.sysname.to_sym} << :guest )
  end

  def roles_string
    roles.map{ |r| r.sysname }
  end

  def self.generate_password( p_length = 8 )
    chars = '1234567890QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm'
    new_pass = ''
    p_length.times do
      new_pass << chars[rand(chars.length)].chr
    end
    new_pass
  end
end
