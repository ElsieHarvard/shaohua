class PeriodicalsController < ApplicationController
	def create_periodical
		return unless need_login
		prd=Periodical.new params.require(:periodical).permit(:prd_title,:prd_no,:prd_info,:prd_msg)
		unless Periodical.exists?(prd_hash:prd.prd_hash)
			prd.save
		else
			prd=Periodical.find_by(prd_hash:prd.prd_hash)
		end
		redirect_to prd
	end
	private
		def periodical_url(prd)
			return "/periodical/"+prd.prd_hash
		end
end