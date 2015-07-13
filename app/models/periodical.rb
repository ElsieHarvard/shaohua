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
#   prd_no
#   prd_title
#   prd_info
#   prf_msg
# ======
class Periodical < ActiveRecord::Base
	after_validation :mkhsh
	def mkhsh
		write_attribute :prd_title,prd_title.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prd_info,prd_info.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prd_msg,prd_msg.gsub('<','&lt;').gsub('>','&gt;')
		write_attribute :prd_hash,OpenSSL::Digest::SHA1.hexdigest(prd_title+prd_no.to_s)
	end
	def self.top(num)
		return self.order(:prd_no).last(num).reverse
	end
end
