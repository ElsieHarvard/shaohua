class WebShellController < ApplicationController
	def global_web_homepage
		@homepage = true
	end
	def ieraw
		@homepage = true
		@ieraw = true
	end
	def r404
		render :template=>"web_shell/404",:status=>404
	end
	def r422
		render :template=>"web_shell/422",:status=>422
	end
	def r500
		render :template=>"web_shell/500",:status=>500
	end
end
