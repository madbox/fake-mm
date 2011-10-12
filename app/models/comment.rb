class Comment < ActiveRecord::Base
#  using_access_control

  belongs_to :article
  belongs_to :user

  validates_presence_of :article
end
