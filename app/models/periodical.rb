class Periodical < ActiveRecord::Base
	def mkhsh
		write_attribute :prdtitle,prdtitle.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdinfo,prdinfo.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdmsg,prdmsg.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdpages,prdpages.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdhash,OpenSSL::Digest::SHA1.hexdigest(prdtitle+prdinfo+prdmsg+prdpages+prdno.to_s)
	end
	def self.top(num)
		return self.order(:prdno).last(num).reverse
	end
end
