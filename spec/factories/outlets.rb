FactoryGirl.define do
  factory :outlet do
    category "vent"
    title "MyString"
    body "MyText"
    urgency 1
    user
  end

  factory :outlet_2, class: Outlet do
    category "rant"
    title "MyString_2"
    body "MyText_2"
    urgency 1
    user
  end

  factory :invalid_outlet, class: Outlet do
    category "qualm"
    title ""
    body ""
    urgency 3
    user factory: :user
  end
end
