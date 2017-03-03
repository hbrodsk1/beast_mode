require "rails_helper"

RSpec.feature "Create new outlet", type: :feature do
	scenario "User successfully creates new outlet" do
		@outlet = FactoryGirl.attributes_for(:outlet)
		@outlet[:user] = FactoryGirl.create(:user)

		login_as(@outlet[:user])
		visit "/outlets/new"

		fill_in('Title', with: @outlet[:title])
		select(@outlet[:category], from: 'outlet_category')
		select(@outlet[:urgency].to_s, from: 'outlet_urgency')
		fill_in('Outlet', with: @outlet[:body])

		click_button('Express Yourself')

		expect(page).to have_current_path(user_path(@outlet[:user]))
	end

	scenario "Outlet is not successfully created" do
		@outlet = FactoryGirl.attributes_for(:outlet)
		@outlet[:user] = FactoryGirl.create(:user)

		login_as(@outlet[:user])
		visit "/outlets/new"

		fill_in('Title', with: "")
		select(@outlet[:category], from: 'outlet_category')
		select(@outlet[:urgency].to_s, from: 'outlet_urgency')
		fill_in('Outlet', with: @outlet[:body])

		click_button('Express Yourself')

		expect(page).to have_button('Express Yourself')
	end
end