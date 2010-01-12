class Comment < ActiveRecord::Base
  belongs_to :article
  has_one :user, :through => :article

  validates_presence_of :article
end
