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

	scenario "params given from bottom-bar-button click" do
		@user = FactoryGirl.create(:user)
		@user_outlets = [FactoryGirl.create(:outlet, user: @user, category: 'rant'),
						FactoryGirl.create(:outlet, user: @user, category: 'qualm'),
						FactoryGirl.create(:outlet, title: "second title", body: "second body", user: @user)]

		login_as(@user)
		visit "/users/#{@user.id}"

		Outlet::ALLOWED_CATEGORIES.each do |category|
			click_on("user-#{category}-button")
			expect(page).to have_current_path(user_path(id: "#{@user.id}", category: category ))
			expect(page).to have_css("div.#{category}")
			visit "/users/#{@user.id}"
		end	
	end

	scenario "page only lists outlets with same category as params" do
		@user = FactoryGirl.create(:user)
		@user_outlets = [FactoryGirl.create(:outlet, user: @user, category: 'rant'),
						FactoryGirl.create(:outlet, user: @user, category: 'qualm'),
						FactoryGirl.create(:outlet, title: "second title", body: "second body", user: @user)]

		login_as(@user)
		visit "/users/#{@user.id}"
		click_on("user-rant-button")

		expect(page).to have_current_path(user_path(id: "#{@user.id}", category: 'rant' ))
		expect(page).to have_css("div.rant")
		expect(page).not_to have_css("div.vent")
		expect(page).not_to have_css("div.qualm")
	end

	scenario "clicks Newest Outlets button" do
		@user = FactoryGirl.create(:user)

		login_as(@user)
		visit "/users/#{@user.id}"
		click_on("newest-outlet-button")

		expect(page).to have_current_path(user_path(id: "#{@user.id}"))
	end

	scenario "user clicks Create Your Own Outlet button" do
		@user = FactoryGirl.create(:user)

		login_as(@user)
		visit "/users/#{@user.id}"
		click_on("create-outlet-button")

		expect(page).to have_current_path(new_outlet_path)
	end

	scenario "user clicks Edit outlet button" do
		@user = FactoryGirl.create(:user)
		@user_outlets = FactoryGirl.create(:outlet, user: @user)

		login_as(@user)
		visit "/users/#{@user.id}"

  		first('#edit-outlet-button').click	

		expect(page).to have_current_path(edit_outlet_path(id: "#{@user_outlets.id}"))
	end

	scenario "user clicks Delete outlet button" do
		@user = FactoryGirl.create(:user)
		@user_outlets = FactoryGirl.create(:outlet, user: @user, category: 'vent')

		login_as(@user)
		visit "/users/#{@user.id}"

		expect(page).to have_css("div.vent")
		
  		first('#delete-outlet-button').click	

		expect(page).to have_current_path(user_path(id: "#{@user.id}"))
		expect(page).not_to have_css("div.vent")
	end

	scenario "user clicks Leave a comment button" do
		@user = FactoryGirl.create(:user)
		@user_outlets = FactoryGirl.create(:outlet, user: @user)

		login_as(@user)
		visit "/users/#{@user.id}"

		first('#create-outlet-comment-button').click
		expect(page).to have_current_path(new_comment_path)
	end

	scenario "user clicks view comments button" do
		@user = FactoryGirl.create(:user)
		@user_outlets = FactoryGirl.create(:outlet, user: @user)

		login_as(@user)
		visit "/users/#{@user.id}"

		first('#view-outlet-comments-button').click
		expect(page).to have_current_path(comments_path(outlet_id: @user_outlets.id))
	end
end