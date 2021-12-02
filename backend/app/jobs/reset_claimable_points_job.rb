class ResetClaimablePointsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    SpacesUser.update_all(user_claimable_points: 100)
    # Do something later
  end
end
