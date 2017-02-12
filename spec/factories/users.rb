FactoryGirl.define do
	factory :user do
		username "test_user"
		email "test_user@email.com"
		password "password"
	end

	factory :user_2, class: User do
		username "test_user_2"
		email "test_user_2@email.com"
		password "password"
	end

	factory :invalid_user, class: User do
		username ""
		email ""
		password ""
	end
end