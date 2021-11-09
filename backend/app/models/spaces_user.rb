class SpacesUser < ApplicationRecord
  belongs_to :space
  belongs_to :user

  enum user_role: { manager: 0, employee: 1 }

  validates :username, presence: true
  validates :user_hashed_password, presence: true
  validates :user_reward_points, presence: true
  validates :user_claimable_points, presence: true
  validates :user_role, inclusion: { in: user_roles }
end
