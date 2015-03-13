class PeriodicalArticle < ActiveRecord::Base
	def mkhsh
		write_attribute :archash,OpenSSL::Digest::SHA256.hexdigest(arcpicture+arctitle+arcpreauthor+arcauthor+arcnumber.to_s+
			arcbeforecontent+arcattrbeforecontent+arccontent+arcattraftercontent+arcaftercontent)
	end
	def arcphsh(src)
		write_attribute :arcpicture,OpenSSL::Digest::SHA256.hexdigest(src)
	end
end
