require "rails_helper"

RSpec.feature "view comments/new page", type: :feature do
	scenario 'user leaves valid comment' do
		@user = FactoryGirl.create(:user)
		@outlet = FactoryGirl.create(:outlet, user: @user)

		login_as(@user)
		visit "/users/#{@user.id}"

		first('#create-outlet-comment-button').click

		first('#comment_outlet_id', visible: false).set("#{@outlet.id}")
		first('#comment_user_id', visible: false).set("#{@user.id}")
		fill_in 'comment_body', with: "Hello, this is a valid comment"
		click_button('comment-submit-button')

		expect(page).to have_current_path(outlet_path(id: @outlet.id))
	end

	scenario 'user leaves invalid comment' do
		@user = FactoryGirl.create(:user)
		@outlet = FactoryGirl.create(:outlet, user: @user)

		login_as(@user)
		visit "/users/#{@user.id}"

		first('#create-outlet-comment-button').click

		first('#comment_outlet_id', visible: false).set("#{@outlet.id}")
		first('#comment_user_id', visible: false).set("#{@user.id}")
		fill_in 'comment_body', with: ""
		click_button('comment-submit-button')

		expect(page).to have_current_path(comments_path)
	end
end