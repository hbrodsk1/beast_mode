FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "test_user#{n}" }
  		sequence(:email)    { |n| "test_user#{n}@email.com" }
		password "password"
	end

	factory :singular_user, class: User do
		username "username"
		email "email@example.com"
		password "password"
	end

	factory :invalid_user, class: User do
		username ""
		email ""
		password ""
	end
end