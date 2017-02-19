FactoryGirl.define do
  factory :comment do
    body "This is a comment"
    user
    outlet
  end

  factory :comment_2, class: Comment do
    body "This is a second comment"
    user
    outlet
  end

  factory :invalid_comment, class: Comment do
    body ""
    user
    outlet
  end  
end
