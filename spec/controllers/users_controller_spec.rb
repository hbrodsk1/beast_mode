require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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

		it "assigns all users as @users" do
			user_1, user_2 = FactoryGirl.create(:user), FactoryGirl.create(:user_2) 
			get :index
			expect(assigns(:users)).to match_array([user_1, user_2])
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

		it "assigns new user as @user" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe '#show' do
		let(:user) { FactoryGirl.create(:user) }

 		it "responds successfuly with an HTTP 200 status code" do
			get :show, params: { id: user }
			expect(response).to have_http_status(200)
		end

		it "render renders the show template" do
			get :show, params: { id: user }
			expect(response).to render_template('show')
		end

		it "assigns the requested user to @user" do
			get :show, params: { id: user }
			expect(assigns(:user)).to eq(user)
		end
	end

	describe '#user_params' do
		let(:params) { FactoryGirl.attributes_for(:user)}
		it "should permit only whitelisted attributes" do
    		is_expected.to permit(:username, :email, :password).for(:create, params: { :user => params} ).on(:user)
    	end
	end

	describe '#create' do
		context "with valid attributes" do
			let(:user_params) { FactoryGirl.attributes_for(:user) }

			it "creates a new user" do
				expect { post :create, params: { :user => user_params } }.to change(User, :count).by(1)
			end

			it "redirects to user page" do
				post :create, params: { :user => user_params }
				expect(response).to redirect_to(User.last)
			end
		end

		context "with invalid attributes" do
			let(:invalid_user_params) { FactoryGirl.attributes_for(:invalid_user) }

			it "does not create a new user" do
				expect { post :create, params: { :user => invalid_user_params } }.to_not change(User, :count)
			end

			it "renders the new template" do
				post :create, params: { :user => invalid_user_params }
				expect(response).to render_template('new')
			end
		end
	end

end
