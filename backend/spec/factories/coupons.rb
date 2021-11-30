FactoryBot.define do
  factory :coupon do
    name { "coupon" }
    code { "ABCXYZ" }
    usuable_at { "amazon" }
    usuable_for { :shopping }
    value { 100 }
    unit { :dollar }
    status { :available }
    expire_at { DateTime.now.next_month }
  end
end
