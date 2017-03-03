require "rails_helper"

RSpec.describe "outlets/new", type: :view do
	it "has a text field for the outlet title" do
		assign(:outlet, FactoryGirl.build(:outlet))
		render

		expect(rendered).to have_selector("#outlet_title")
	end

	it "has a text area for the outlet body" do
		assign(:outlet, FactoryGirl.build(:outlet))
		render

		expect(rendered).to have_selector("#outlet_body")
	end

	it "has a button to submit a new outlet" do
		assign(:outlet, FactoryGirl.build(:outlet))
		render

		expect(rendered).to have_button("Express Yourself")
	end

	it "has a select box for the outlet category" do
		assign(:outlet, FactoryGirl.build(:outlet))
		select_options = Outlet::ALLOWED_CATEGORIES.map { |category| category }
		render

		expect(rendered).to have_select('outlet_category', options: select_options )
	end

	it "has a select box for the urgency of the outlet" do
		assign(:outlet, FactoryGirl.build(:outlet))
		one_through_ten = (1..10).map { |urgency| urgency.to_s }
		render

		expect(rendered).to have_select('outlet_urgency', options: ( one_through_ten ))
	end
end