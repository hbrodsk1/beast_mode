class StaticPagesController < ApplicationController

	def rundown
		@valid_outlets = Outlet::ALLOWED_CATEGORIES
	end
end
