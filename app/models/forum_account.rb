class ForumAccount < ActiveRecord::Base
	def self.empty_new
		self.new( user_name:"游客", user_information:"账户积分;0\r\n个性签名;\r\n管理权限;nil\r\n权限版块;nil\r\n" )
	end
	def user_info
		result = Hash.new
		user_information.each_line do |line|
			k,v = line.split(";",2)
			result[k] = v
		end
		return result
	end
end
