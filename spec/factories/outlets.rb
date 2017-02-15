FactoryGirl.define do
  factory :outlet do
    type "Outlet"
    title "MyString"
    body "MyText"
    urgency 1
    user factory: :user
  end

  factory :outlet_2, class: Outlet do
    type "Outlet"
    title "MyString_2"
    body "MyText_2"
    urgency 2
    user factory: :user_2
  end

  factory :invalid_outlet, class: Outlet do
    type "Outlet"
    title ""
    body ""
    urgency 3
    user factory: :user
  end
end
