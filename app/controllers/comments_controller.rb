class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		@outlet = Outlet.find(params[:outlet_id])
		@comment = @outlet.comments.build(comment_params)
		@comment.user_id = User.find(params[:user_id]).id
		

		if @comment.save
			redirect_to(@outlet)
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
