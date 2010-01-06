class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user, :through => :article

  validates_presence_of :article
end
