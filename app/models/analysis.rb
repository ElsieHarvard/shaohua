class Analysis < ActiveRecord::Base
	def self.toparticle(num)
		return self.order(:arcview).last(num).collect{|ana|Article.find(ana.arcid)}.reverse
	end
	def self.navtop(type,num)
		return self.where(arctype:type).order(:arcview).last(num).collect{|ana|Article.find(ana.arcid)}.reverse
	end
end
