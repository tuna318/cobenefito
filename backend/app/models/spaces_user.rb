class SpacesUser < ApplicationRecord
  belongs_to :space
  belongs_to :user

  enum user_role: { manager: 0, employee: 1 }

  validates :username, presence: true
  validates :user_password_digest, presence: true
  validates :user_role, inclusion: { in: user_roles }

  has_secure_password :user_password
end
