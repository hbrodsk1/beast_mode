require "rails_helper"

RSpec.describe "static_pages/rundown", type: :view do
	it "displays each outlet name" do
		assign(:valid_outlets, Outlet::ALLOWED_CATEGORIES)
		render

		Outlet::ALLOWED_CATEGORIES.each do |category|
			expect(rendered).to include(category)
		end
	end

	it "renders each outlets description partial" do
		assign(:valid_outlets, Outlet::ALLOWED_CATEGORIES)
		render

		Outlet::ALLOWED_CATEGORIES.each do |category|
			expect(view).to render_template(:partial => "descriptions/_#{category}")
		end
	end

	it "links each category name to a filtered list at outlet/index" do
		assign(:valid_outlets, Outlet::ALLOWED_CATEGORIES)
		render

		Outlet::ALLOWED_CATEGORIES.each do |category|
			expect(rendered).to have_link(category, href: outlets_path(category: category))
		end
	end
end