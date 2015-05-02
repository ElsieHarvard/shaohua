# ======
#  model Periodical 
# ======
#  Meta Data     
# ------
#  prd_hash
# ------
#  Info          
# ------
# [periodical]
#   prd_title
#   prd_info
#   prf_msg
# ======
class Periodical < ActiveRecord::Base
	after_validation :mkhsh
	def mkhsh
		write_attribute :prdtitle,prdtitle.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdinfo,prdinfo.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdmsg,prdmsg.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prdhash,OpenSSL::Digest::SHA1.hexdigest(prdtitle+prdinfo+prdmsg+prdpages+prdno.to_s)
	end
	def self.top(num)
		return self.order(:prd_no).last(num).reverse
	end
end
