require 'rails_helper'

RSpec.describe Outlet, type: :model do

	it "has a valid factory" do
		expect(FactoryGirl.create(:outlet)).to be_valid
	end

	context 'association' do
		it { is_expected.to belong_to(:user) }
	end

	context 'validations' do
		it { is_expected.to validate_presence_of(:category) }
		it { is_expected.to validate_inclusion_of(:category).in_array(['vent', 'rant', 'qualm']) }
		it { is_expected.to validate_presence_of(:title) }
		it { is_expected.to validate_length_of(:title) }
		it { is_expected.to validate_presence_of(:body) }
		it { is_expected.to validate_length_of(:body) }
		it { is_expected.to validate_presence_of(:urgency) }
		
		it "is invalid without a category" do
			expect(FactoryGirl.build(:outlet, category: nil)).to be_invalid
		end

		it "is invalid with a category not included in the accepted list of categories" do
			expect(FactoryGirl.build(:outlet, category: 'invalid_category')).to be_invalid
		end

		it "is invalid without a title" do
			expect(FactoryGirl.build(:outlet, title: nil)).to be_invalid
		end

		it "is invalid with a title longer than 60 characters" do
			invalid_title = "a" * 61
			expect(FactoryGirl.build(:outlet, title: invalid_title)).to be_invalid
		end

		it "is invalid without a body" do
			expect(FactoryGirl.build(:outlet, body: nil)).to be_invalid
		end

		it "is invalid with a body longer than 1000 characters" do
			invalid_body = "a" * 1001
			expect(FactoryGirl.build(:outlet, title: invalid_body)).to be_invalid
		end

		it "is invalid without a urgency" do
			expect(FactoryGirl.build(:outlet, urgency: nil)).to be_invalid
		end

		it "is invalid with a non integer urgency" do
			expect(FactoryGirl.build(:outlet, urgency: "string")).to be_invalid
		end

		it "is invalid with an urgency less than 1" do
			expect(FactoryGirl.build(:outlet, urgency: 0)).to be_invalid
		end

		it "is invalid with an urgency greater than 10" do
			expect(FactoryGirl.build(:outlet, urgency: 11)).to be_invalid
		end
	end
end
