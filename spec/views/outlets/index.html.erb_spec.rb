require "rails_helper"

RSpec.describe "outlets/index", type: :view do
	context "with no parameters" do
		it "displays each outlet" do
			assign(:outlets, [
	       		FactoryGirl.create(:outlet, title: "first"),
	       		FactoryGirl.create(:outlet, title: "second")
	      ])
			render

			expect(rendered).to match /first/
			expect(rendered).to match /second/
		end
	end
end