class CommentsController < ApplicationController

	def index
		@outlet = Outlet.find(params[:outlet_id])
		@comments = @outlet.comments.all
	end

	def new
		@comment = Comment.new
		@outlet = Outlet.find(params[:outlet_id])
		@user = current_user
	end

	def create
		@outlet = Outlet.find(params[:comment][:outlet_id])
		@comment = @outlet.comments.build(comment_params)
		@comment.user_id = params[:comment][:user_id]
		

		if @comment.save
			redirect_to(@outlet)
		else
			render "new"
		end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params)
			redirect_to @comment.outlet
		end
	end

	def destroy
		@comment = Comment.find(params[:id])

		if @comment.destroy
			redirect_to @comment.outlet
		end
	end


	private
	def comment_params
		params.require(:comment).permit(:body, :outlet, :user, :parent_id)
	end
end
