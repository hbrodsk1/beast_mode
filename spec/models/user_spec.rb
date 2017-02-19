require 'rails_helper'

RSpec.describe User, type: :model do

	it "has a valid factory" do
		expect(FactoryGirl.create(:user)).to be_valid
	end

	context 'associations' do
		it { is_expected.to have_many(:outlets) }
		it { is_expected.to have_many(:comments) }
	end

	context 'validations' do
		it { is_expected.to validate_presence_of(:username) }
		it { is_expected.to validate_presence_of(:email) }
		it { is_expected.to validate_presence_of(:password) }
		it { is_expected.to validate_length_of(:password).is_at_least(5).is_at_most(30) }

		it "is invalid with no username" do
			expect(FactoryGirl.build(:user, username: nil)).to be_invalid
		end

		it "is invalid with no email" do
			expect(FactoryGirl.build(:user, email: nil)).to be_invalid
		end

		it "is invalid with no password" do
			expect(FactoryGirl.build(:user, password: nil)).to be_invalid
		end

		it "is invalid with password under 5 characters" do
			expect(FactoryGirl.build(:user, password: "1234")).to be_invalid
		end

		it "is invalid with password over 30 characters" do
			expect(FactoryGirl.build(:user, password: "abcdefghijklmnopqrstuvwxyzabcde")).to be_invalid
		end
	end	
end
