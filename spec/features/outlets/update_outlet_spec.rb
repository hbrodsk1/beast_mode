require "rails_helper"

RSpec.feature "Create new outlet", type: :feature do
	scenario "User updates outlet" do
		@outlet = FactoryGirl.create(:outlet)

		login_as(@outlet.user)

		visit "outlets/#{@outlet.id}/edit"

		fill_in('Title', with: 'New Title')
		select(@outlet[:category], from: 'outlet_category')
		select(@outlet[:urgency].to_s, from: 'outlet_urgency')
		fill_in('Outlet', with: @outlet[:body])

		click_button('Update Your Expression')

		expect(page).to have_current_path(outlet_path(@outlet))
	end

	scenario "User updates outlet with invalid information" do
		@outlet = FactoryGirl.create(:outlet)

		login_as(@outlet.user)

		visit "outlets/#{@outlet.id}/edit"

		fill_in('Title', with: '')
		select(@outlet[:category], from: 'outlet_category')
		select(@outlet[:urgency].to_s, from: 'outlet_urgency')
		fill_in('Outlet', with: @outlet[:body])

		click_button('Update Your Expression')

		expect(page).to have_current_path(outlet_path(@outlet))
	end
end