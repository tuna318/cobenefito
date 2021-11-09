class SpacesUser < ApplicationRecord
  belongs_to :space
  belongs_to :user

  enum role: { manager: 0, employee: 1 }
end
