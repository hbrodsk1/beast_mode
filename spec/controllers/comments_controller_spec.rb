require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

	describe '#index' do
		before :each do
			@outlet = FactoryGirl.create(:outlet)
			@comments = [FactoryGirl.create(:comment, outlet: @outlet),
						FactoryGirl.create(:comment, outlet: @outlet, body: 'Second Comment')]
		end

		it "responds successfully with an HTTP 200 status code" do
			get :index, params: { outlet_id: @outlet.id }
			expect(response).to have_http_status(200)
		end

		it "renders the index template" do
			get :index, params: { outlet_id: @outlet.id }
			expect(response).to render_template('index')
		end

		it "assigns outlet comments as @comments" do
			get :index, params: { outlet_id: @outlet.id }
			expect(assigns(:comments)).to eq(@comments)
		end
	end

	describe '#new' do
		before :each do
			@outlet = FactoryGirl.create(:outlet)
		end
		it "responds successfully with an HTTP 200 status code" do
			get :new, params: { outlet_id: @outlet.id }
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			get :new, params: { outlet_id: @outlet.id }
			expect(response).to render_template('new')
		end

		it "assigns new comment as @comment" do
			get :new, params: { outlet_id: @outlet.id }
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

            let(:create) { post :create, params: { comment: { outlet_id: @outlet.id, user_id: @user.id, body: @comment_params[:body] } } }

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

			let(:create) { post :create, params: { comment: { outlet_id: @outlet.id, user_id: @user.id, body: @invalid_comment_params[:body] } } }

			it "does not create a new comment" do
				expect { create }.to change { Comment.count }.by(0)
			end
        end

        context 'as child comment' do
        	before :each do
        		@comment = FactoryGirl.create(:comment)
        		@child_comment_params = FactoryGirl.attributes_for(:child_comment, parent_id: @comment.id)
        	end

        	let(:create) { post :create, params: {comment: { outlet_id: @comment.outlet_id, user_id: @comment.user_id, parent_id: @child_comment_params[:parent_id], body: @child_comment_params[:body] } } }

        	it "creates a new child comment" do
				expect { create }.to change { @comment.children.count }.by(1)
			end

			it "increases outlet comment count by 1" do
				expect { create }.to change { @comment.outlet.comments.count }.by(1)
			end
        end

        context 'as a grandchild comment' do
        	before :each do
        		@child_comment = FactoryGirl.create(:child_comment)
        		@grandchild_comment_params = FactoryGirl.attributes_for(:grandchild_comment, parent_id: @child_comment.id)
        	end

        	let(:create) { post :create, params: {comment: { outlet_id: @child_comment.outlet_id, user_id: @child_comment.user_id, parent_id: @grandchild_comment_params[:parent_id], body: @grandchild_comment_params[:body] } } }

        	it "creates a new grandchild comment" do
        		expect { create }.to change { @child_comment.children.count }.by(1)
        	end

        	it "increases outlet comment count by 1" do
				expect { create }.to change { @child_comment.outlet.comments.count }.by(1)
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

	describe '#comment_params' do
		let(:user) { FactoryGirl.create(:user) }
		let(:outlet) { FactoryGirl.create(:outlet) }
		let(:params) { FactoryGirl.attributes_for(:comment)}

		login_user

		it "should permit only whitelisted attributes" do
    		is_expected.to permit(:body, :outlet, :user, :parent_id).for(:create, params: {comment: { outlet_id: outlet, user_id: user, comment: params} } ).on(:comment)
    	end
	end
end
