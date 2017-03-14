require "rails_helper"

RSpec.describe "users/show", type: :view do
	context "user has outlets" do
		before(:all) do
			@user = FactoryGirl.create(:user)
			@user_outlets = [FactoryGirl.create(:outlet, user: @user),
						FactoryGirl.create(:outlet, title: "second title", body: "second body", user: @user)]
		end

		it "displays the user's outlets" do
			render

			expect(rendered).to match /MyString/
			expect(rendered).to match /MyText/
			expect(rendered).to match /second title/
			expect(rendered).to match /second body/
		end
	end

	context "user does not have outlets" do
		it "renders no outlets message" do
			@user = FactoryGirl.create(:user)

			render

			expect(rendered).to match /This user does not have any outlets... yet/
		end
	end
end