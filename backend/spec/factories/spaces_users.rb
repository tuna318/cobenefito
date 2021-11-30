FactoryBot.define do
  factory :spaces_user do
    username { "username" }
    user_password { "password" }

    factory :spaces_user_employee do
      user_role { "employee" }
      user_claimable_points { 100 }
      user_reward_points { 100 }
    end

    factory :spaces_user_manager do
      user_role { "manager" }
      user_claimable_points { 0 }
      user_reward_points { 0 }
    end
  end
end
