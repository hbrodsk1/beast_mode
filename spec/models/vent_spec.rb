require 'rails_helper'

RSpec.describe Vent, type: :model do
  
  it "has a valid factory" do
  	expect(FactoryGirl.create(:vent)).to be_valid
  end

  it "inherits from the Outlet class" do
  	expect(Vent).to be < Outlet
  end
end
