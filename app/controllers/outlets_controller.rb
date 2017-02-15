class OutletsController < ApplicationController

	def index
		@outlets = Outlet.all
	end

	def new
		@outlet = Outlet.new
	end

	def create
		@user = User.find(params[:id])
		@outlet = @user.outlets.build(outlet_params)

		if @outlet.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@outlet = Outlet.find(params[:id])
	end

	def edit
		@outlet = Outlet.find(params[:id])
	end

	def update
		@outlet = Outlet.find(params[:id])

		if @outlet.update(outlet_params)
			redirect_to(@outlet)
		else
			render 'edit'
		end
	end

	def destroy
		@outlet = Outlet.find(params[:id])

		if @outlet.destroy
			redirect_to outlets_path
		end
	end

	private

	def outlet_params
		params.require(:outlet).permit(:type, :title, :body, :urgency, :user)
	end
end
