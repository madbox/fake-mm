class Assigment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validate :uniqueness

  def uniqueness
    errors.add(:role, "Assigment already exists") if Assigment.scoped_by_user_id_and_role_id(user_id, role_id).count > 0
  end
end
