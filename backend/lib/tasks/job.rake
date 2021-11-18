namespace :job do
  desc "Task to reset employee claimable points each month"
  task reset_claimable_points: :environment do
    ResetClaimablePointsJob.perform_now
  end

end
