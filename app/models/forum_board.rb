class ForumBoard < ActiveRecord::Base
	before_validation :get_hash
	private
		def get_hash
			string_remove_space self.board_name
			write_attribute :board_hash,OpenSSL::Digest::SHA256.hexdigest(board_name)
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
end
