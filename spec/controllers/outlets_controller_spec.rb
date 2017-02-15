require 'rails_helper'

RSpec.describe OutletsController, type: :controller do

	describe '#index' do
		it "responds successfully with an HTTP 200 status code" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the index template" do
			get :index
			expect(response).to render_template('index')
		end

		it "assigns all outlets as @outlets" do
			outlet_1, outlet_2 = FactoryGirl.create(:outlet), FactoryGirl.create(:outlet_2) 
			get :index
			expect(assigns(:outlets)).to match_array([outlet_1, outlet_2])
		end
	end

	describe '#new' do
		it "responds successfully with an HTTP 200 status code" do
			get :new
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end

		it "assigns new outlet as @outlet" do
			get :new
			expect(assigns(:outlet)).to be_a_new(Outlet)
		end
	end

	describe '#show' do
		let(:outlet) { FactoryGirl.create(:outlet) }

 		it "responds successfuly with an HTTP 200 status code" do
			get :show, params: { id: outlet }
			expect(response).to have_http_status(200)
		end

		it "render renders the show template" do
			get :show, params: { id: outlet }
			expect(response).to render_template('show')
		end

		it "assigns the requested user to @user" do
			get :show, params: { id: outlet }
			expect(assigns(:outlet)).to eq(outlet)
		end
	end

	describe '#create' do
		context "with valid attributes" do
			let(:user) { FactoryGirl.create(:user) }
			let(:outlet_params) { FactoryGirl.attributes_for(:outlet) }

			it "creates a new outlet" do
				expect { post :create, params: { id: user, :outlet => outlet_params } }.to change(Outlet, :count).by(1)
			end

			it "should increase the user's outlet count by one" do
				expect { post :create, params: { id: user, :outlet => outlet_params } }.to change(user.outlets, :count).by(1)
			end

			it "redirects to user page" do
				post :create, params: { id: user, :outlet => outlet_params }
				expect(response).to redirect_to(assigns(:user))
			end
		end

		context "with invalid attributes" do
			let(:user) { FactoryGirl.create(:user) }
			let(:invalid_outlet_params) { FactoryGirl.attributes_for(:invalid_outlet) }

			it "does not create a new outlet" do
				expect { post :create, params: { id: user, :outlet => invalid_outlet_params } }.to_not change(Outlet, :count)
			end

			it "renders the new template" do
				post :create, params: { id: user, :outlet => invalid_outlet_params }
				expect(response).to render_template('new')
			end
		end
	end

	describe '#edit' do
		let(:outlet) { FactoryGirl.create(:outlet) }

		it "responds successfully with an HTTP 200 status code" do
			get :edit, params: { id: outlet }
			expect(response).to have_http_status(200)
		end

		it "renders the edit template" do
			get :edit, params: { id: outlet }
			expect(response).to render_template('edit')
		end

		it "assigns the requested user to @outlet" do
			get :edit, params: { id: outlet }
			expect(assigns(:outlet)).to eq(outlet)
		end
	end

	describe '#update' do
		let(:outlet) { FactoryGirl.create(:outlet) }
		let(:updated_attributes) { FactoryGirl.attributes_for(:outlet_2) }
		let(:invalid_updated_attributes) { FactoryGirl.attributes_for(:invalid_outlet) }

		context "with valid attributes" do
			it "assigns the requested user to @outlet" do
				patch :update, params: { id: outlet, :outlet => updated_attributes }
				expect(assigns(:outlet)).to eq(outlet)
			end

			it "updates user attributes" do
				patch :update, params: { id: outlet, :outlet => updated_attributes }
				outlet.reload
				expect(outlet).to have_attributes(FactoryGirl.attributes_for(:outlet_2))
			end

			it "redirects to user page" do
				patch :update, params: { id: outlet, :outlet => updated_attributes }
				expect(response).to redirect_to(outlet_url(outlet))
			end
		end

		context "with invalid attributes" do
			it "does not update user" do
				patch :update, params: { id: outlet, :outlet => invalid_updated_attributes }
				outlet.reload
				expect(outlet).to have_attributes(FactoryGirl.attributes_for(:outlet))
			end

			it "renders the edit template" do
				patch :update, params: { id: outlet, :outlet => invalid_updated_attributes }
				expect(response).to render_template('edit')
			end
		end
	end

	describe '#destroy' do
		before :each do 
			@outlet = FactoryGirl.create(:outlet)
  		end

		it "assigns the requested user to @outlet" do
			delete :destroy, params: { id: @outlet }
			expect(assigns(:outlet)).to eq(@outlet)
		end

		it "deletes the requested user" do
			expect { delete :destroy, params: { id: @outlet } }.to change(Outlet, :count).by(-1)
		end

		it "redirects to the user index page" do
			delete :destroy, params: { id: @outlet }
			expect(response).to redirect_to(outlets_url) 
		end
	end


	describe '#outlet_params' do
		let(:user) { FactoryGirl.create(:user) }
		let(:params) { FactoryGirl.attributes_for(:outlet)}
		it "should permit only whitelisted attributes" do
    		is_expected.to permit(:type, :title, :body, :urgency, :user).for(:create, params: { id: user, outlet: params} ).on(:outlet)
    	end
	end
end
