# ======
#  model Article 
# ======
#  Meta Data     
# ------
#  arc_hash
#  arc_author_hash
# ------
#  Info          
# ------
# [article]
#   arc_title
#   arc_type
# [author]
#   arc_preauthor
#   arc_author
# [content]
#   arc_beforecontent
#   arc_attrbeforecontent
#   *arc_content*
#   arc_attraftercontent
#   arc_aftercontent
# [picture]
#   arc_picture
# [periodical]
#   arc_prdhash
#   arc_prdnumber
# ------
#  Analysis      
# ------
#  arc_view
#  arc_top
#  arc_tag
# ======
class Article < ActiveRecord::Base
	before_validation :remove_space
	after_validation :get_arc_hash
	def self.toparticle(num)
		return self.order(:arc_rate).last(num).reverse
	end
	def self.navtop(type,num)
		return self.where(arc_type:type).order(:arc_rate).last(num).reverse
	end
	def self.same_author(author_hash)
		return self.where(arc_author_hash:author_hash)
	end
	def arcphsh(src)
		write_attribute :arcpicture,OpenSSL::Digest::SHA256.hexdigest(src)
	end
	private
		def get_arc_hash
			write_attribute :arc_hash,OpenSSL::Digest::SHA1.hexdigest(arc_content)
			write_attribute :arc_author_hash,OpenSSL::Digest::SHA1.hexdigest(arc_author)
		end
		def remove_space
			string_remove_all_space self.arc_title
			string_remove_all_space self.arc_type
			string_remove_all_space self.arc_preauthor
			string_remove_all_space self.arc_author
			string_remove_space     self.arc_beforecontent
			string_remove_space     self.arc_attrbeforecontent
			string_remove_space     self.arc_content
			string_remove_space     self.arc_attraftercontent
			string_remove_space     self.arc_aftercontent
			string_remove_all_space self.arc_picture
			string_remove_all_space self.arc_prdhash
			return self
		end
		def string_remove_space(src)
			return if src == nil
			src.gsub!("\u3000",'  ')
			src.gsub!("\u2022","\u00B7")
			src.gsub!("\t",'    ')
			src.gsub!("\r","\n")
			src.gsub!(/\A\s*/,'')
			src.gsub!(/\s*\Z/,'')
			src.gsub!(/ *\n+ */,"\r\n")
			src.gsub!('<','&lt;')
			src.gsub!('>','&gt;')
		end
		def string_remove_all_space(src)
			return if src == nil
			string_remove_space src
			src.gsub!(' ','')
		end
end
# CREATE TABLE "articles" ("id"                    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
#                          "arc_title"             varchar, 
#                          "arc_type"              varchar, 
#                          "arc_preauthor"         varchar, 
#                          "arc_author"            varchar, 
#                          "arc_beforecontent"     text, 
#                          "arc_attrbeforecontent" varchar, 
#                          "arc_content"           text, 
#                          "arc_attraftercontent"  varchar, 
#                          "arc_aftercontent"      text, 
#                          "arc_picture"           varchar, 
#                          "arc_prdhash"           varchar, 
#                          "arc_prdnumber"         varchar, 
#                          "arc_view"              integer, 
#                          "arc_top"               integer, 
#                          "arc_tag"               text, 
#                          "arc_hash"              varchar)
