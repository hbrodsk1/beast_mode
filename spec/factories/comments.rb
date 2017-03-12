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

  factory :child_comment, class: Comment do
    body "This is a child comment"
    user
    outlet
    parent_id { FactoryGirl.create(:comment).id }
  end

  factory :grandchild_comment, class: Comment do
    body "This is a grandchild comment"
    user
    outlet
    parent_id { FactoryGirl.create(:child_comment).id }
  end 
end
