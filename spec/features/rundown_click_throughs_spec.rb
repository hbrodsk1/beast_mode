require "rails_helper"

RSpec.feature "Rundown Click Throughs", type: :feature do
  scenario "User clicks 'Create Your Own' button" do
    visit "/static_pages/rundown"

    click_button("Create Your Own")

    expect(page).to have_current_path(new_outlet_path)
  end

  scenario "User clicks specific outlet type" do
  	visit "/static_pages/rundown"

  	Outlet::ALLOWED_CATEGORIES.each do |category|
      click_on("#{category}" + "-heading")
  		expect(page).to have_current_path(outlets_path(category: category))

  		visit "/static_pages/rundown"
  	end
  end

  scenario "User clicks outlet button to jump to specific outlet ID" do
    visit "/static_pages/rundown"

    Outlet::ALLOWED_CATEGORIES.each do |category|
      click_button("Outlets")
      click_on("#{category}" + "-info-link")

      expect(page).to have_xpath("//a", :id => "#{category}" + "-heading")
    end
  end
end