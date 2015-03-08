class PeriodicalArticle < ActiveRecord::Base
	def mkhsh
		write_attribute :archash,Digest::SHA3.hexdigest(arcpicture+arctitle+arcpreauthor+arcauthor+arcnumber.to_s+
			arcbeforecontent+arcattrbeforecontent+arccontent+arcattraftercontent+arcaftercontent)
	end
	def arcphsh(src)
		write_attribute :arcpicture,Digest::SHA3.hexdigest(src)
	end
end
