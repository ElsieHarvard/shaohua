class Article < ActiveRecord::Base
	def makeuparc
		string_remove_all_space self.arctitle
		string_remove_all_space self.arcauthor
		string_remove_space self.arccontent
		write_attribute :archash,Digest::SHA1.hexdigest(self.arctitle+self.arcauthor+self.arccontent)
	end
	def self.arcfind(hsh)
		return self.find_by archash: hsh
	end
	private
	def string_remove_space(src)
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
		string_remove_space src
		src.gsub!(' ','')
	end
end
