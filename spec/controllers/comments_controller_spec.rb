require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

	describe '#new' do
		it "responds successfully with an HTTP 200 status code" do
			get :new
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end

		it "assigns new comment as @comment" do
			get :new
			expect(assigns(:comment)).to be_a_new(Comment)
		end
	end

	describe '#create' do
		context 'with valid attributes' do 
			before :each do
				@outlet = FactoryGirl.create(:outlet)
				@user = FactoryGirl.create(:user)
				@comment_params =  FactoryGirl.attributes_for(:comment)
			end

            let(:create) { post :create, params: { outlet_id: @outlet.id, user_id: @user.id, comment: @comment_params } }

            it "creates new comment" do
                expect { create }.to change { Comment.count }.by(1)
            end

            it "increases the post comment count by 1" do
            	expect { create }.to change { @outlet.comments.count }.by(1)
            end

            it "increases user comment count by 1" do
            	expect { create }.to change { @user.comments.count }.by(1)
            end
        end

        context 'with invalid attributes' do
        	before :each do
				@outlet = FactoryGirl.create(:outlet)
				@user = FactoryGirl.create(:user)
				@invalid_comment_params =  FactoryGirl.attributes_for(:invalid_comment)
			end

			let(:create) { post :create, params: { outlet_id: @outlet.id, user_id: @user.id, comment: @invalid_comment_params } }

			it "does not create a new comment" do
				expect { create }.to change { Comment.count }.by(0)
			end
        end
	end

	describe '#edit' do
		let(:comment) { FactoryGirl.create(:comment) }

		it "responds successfully with an HTTP 200 status code" do
			get :edit, params: { id: comment}
			expect(response).to have_http_status(200)
		end

		it "renders the edit template" do
			get :edit, params: { id: comment}
			expect(response).to render_template('edit')
		end

		it "assigns the selected comment to @comment" do
			get :edit, params: { id: comment}
			expect(assigns(:comment)).to eq(comment)
		end
	end

	describe '#update' do
		context 'with valid attributes' do 
			before :each do
				@outlet = FactoryGirl.create(:outlet)
				@user = FactoryGirl.create(:user)
				@comment =  FactoryGirl.create(:comment)
				@updated_comment_attributes = FactoryGirl.attributes_for(:comment_2)
			end

            let(:update) { patch :update, params: { id: @comment, comment: @updated_comment_attributes } }

            it "assigns the selected comment to @comment" do
				update
				expect(assigns(:comment)).to eq(@comment)
			end

            it "updates the comment's attributes" do
                update
                @comment.reload
                expect(@comment).to have_attributes(@updated_comment_attributes)
            end

            it "redirects to the comment's outlet" do
            	update
            	expect(response).to redirect_to(@comment.outlet)
            end
        end

        context 'with invalid attributes' do
        	before :each do
				@outlet = FactoryGirl.create(:outlet)
				@user = FactoryGirl.create(:user)
				@comment =  FactoryGirl.create(:comment)
				@invalid_comment_attributes = FactoryGirl.attributes_for(:invalid_comment)
			end

	        let(:update) { patch :update, params: { id: @comment, comment: @invalid_comment_attributes } }

			it "assigns the selected comment to @comment" do
				update
				expect(assigns(:comment)).to eq(@comment)
			end

            it "updates the comment's attributes" do
                update
                @comment.reload
                expect(@comment).to have_attributes(FactoryGirl.attributes_for(:comment))
            end
        end
	end

	describe '#destroy' do
		before(:each) do
			@comment = FactoryGirl.create(:comment)
		end

		let(:destroy) { delete :destroy, params: { id: @comment } }

		it "assigns the requested comment to comment" do
			destroy
			expect(assigns(:comment)).to eq(@comment)
		end

		it "deletes the comment" do    
			expect { destroy }.to change{ Comment.count }.by(-1)
		end

		it "redirects to the comment's outlet" do
			destroy
			expect(response).to redirect_to(@comment.outlet)
		end
	end
end
