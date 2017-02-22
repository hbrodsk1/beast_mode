require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

	describe '#rundown' do
		it "responds successfully with an HTTP 200 status code" do
			get :rundown
			expect(response).to have_http_status(200)
		end

		it "render the rundown template" do
			get :rundown
			expect(response).to render_template('rundown')
		end

		it "ensures @valid_outlets same number of elements as the allowed outlets" do
			get :rundown
			expect(assigns(:valid_outlets).length).to eq(Outlet::ALLOWED_CATEGORIES.length)
		end
	end
end
