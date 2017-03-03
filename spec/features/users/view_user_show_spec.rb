require "rails_helper"

RSpec.feature "view user/show page", type: :feature do
	scenario "user has outlets" do
		@user = FactoryGirl.create(:user)
		outlets = [FactoryGirl.create(:outlet, user: @user),
					FactoryGirl.create(:outlet, title: "second title", body: "second body", user: @user)]

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).to have_css('div.user-outlet')
	end

	scenario "user does not have outlets" do
		@user = FactoryGirl.create(:user)

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).not_to have_css('div.user-outlet')
	end
end