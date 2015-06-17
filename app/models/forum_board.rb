class ForumBoard < ActiveRecord::Base
	before_validation :get_hash
	private
	def get_hash
		write_attribute :board_hash,OpenSSL::Digest::SHA256.hexdigest(board_name)
	end
end
