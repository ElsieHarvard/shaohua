class Article < ActiveRecord::Base
	def makeuparc
		string_remove_space self.arctitle
		string_remove_space self.arcauthor
		string_remove_space self.arccontent
		string_fix_type_arc self.arctype
	end
	private
	def string_remove_space(src)
		src.gsub!(/\u3000/,'  ')
		src.gsub!(/\t/,'    ')
		src.gsub!(/\r/,"\n")
		src.gsub!(/\n+/,"\r\n")
		src.gsub!(/\A\s*/,'')
		src.gsub!(/\s\Z*/,'')
		src.gsub!(/\s*\r\n\s*/,"\r\n")
		src.gsub!('<','&lt;')
		src.gsub!('>','&gt;')
	end
	def string_fix_type_arc(src)
		
	end
end
