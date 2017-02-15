FactoryGirl.define do
  factory :vent do
    type "vent"
    title "MyVentTitle"
    body "MyVent"
    urgency 1
    user factory: :user
  end
end
