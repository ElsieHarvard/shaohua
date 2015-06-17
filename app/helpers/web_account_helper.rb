module WebAccountHelper
	def who_is_that
		if usrlogin
			return ForumAccount.find_by(user_hash:cookies.signed[:forum_user_hash])||ForumAccount.empty_new
		else
			return ForumAccount.empty_new
		end
	end
end
