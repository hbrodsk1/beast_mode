require "rails_helper"

RSpec.feature "outlet box comment count", type: :feature do
	scenario 'outlet has no comments' do
		@user = FactoryGirl.create(:user)
		@user_outlets = FactoryGirl.create(:outlet, user: @user)

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).to have_css('a#view-outlet-comments-button', :text => "All Comments (0)")
	end

	scenario 'outlet has comments' do
		@user = FactoryGirl.create(:user)
		@user_outlets = FactoryGirl.create(:outlet, user: @user)
		@comment = FactoryGirl.create(:comment, outlet: @user_outlets)

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).to have_css('a#view-outlet-comments-button', :text => "All Comments (1)")
	end
end