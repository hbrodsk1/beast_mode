require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  it "has a valid factory" do
  	expect(FactoryGirl.create(:comment)).to be_valid
  end

  context 'associations' do
  	it { is_expected.to belong_to(:user) }
  	it { is_expected.to belong_to(:outlet) }
  end

  context 'validations' do
  	it { is_expected.to validate_presence_of(:body) }
  	it { is_expected.to validate_length_of(:body) }
  	it { is_expected.to validate_presence_of(:user) }
  	it { is_expected.to validate_presence_of(:outlet) }

  	it "is invalid without a body" do
  		expect(FactoryGirl.build(:comment, body: nil)).to be_invalid
  	end

  	it "is invalid without a user" do
  		expect(FactoryGirl.build(:comment, user: nil)).to be_invalid
  	end

  	it "is invalid without a outlet" do
  		expect(FactoryGirl.build(:comment, outlet: nil)).to be_invalid
  	end

  	it "is invalid with a body longer than 1000 characters" do
		invalid_body = "a" * 1001
		expect(FactoryGirl.build(:comment, body: invalid_body)).to be_invalid
	end
  end
end
