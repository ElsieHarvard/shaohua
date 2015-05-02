module ApplicationHelper
	def title(page_title)
		content_for(:title){page_title}
	end
	def mkhsh(src)
		Digest::SHA1.hexdigest src
	end
	def navlogin
		if usracc=usrlogin
			return 'web_shell/user_account',usracc
		else
			return 'web_shell/login',nil
		end
	end
	def usrlogin
		return (WebAccount.find_by(usrhash:cookies.signed[:webuser]) rescue nil)
	end
	def raise404
		return render :template=>"web_shell/404",:status=>404
	end
end
