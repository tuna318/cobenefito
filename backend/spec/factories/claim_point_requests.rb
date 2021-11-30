FactoryBot.define do
  factory :claim_point_request do
    title { "claim points request" }
    status { "pending" }
    reference_link { "https://hogehoge/hogehoge" }
    claim_points { 20 }
  end
end
